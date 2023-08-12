import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_trip_xc/dao/travel_dao.dart';
import 'package:flutter_trip_xc/model/travel_model.dart';
import 'package:flutter_trip_xc/model/travel_tab_model.dart';
import 'package:flutter_trip_xc/widget/loading_container.dart';

import '../dao/travel_tab_dao.dart';

const travelUrl = 'https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5';
const pageSize = 10;
class TravelTabPage extends StatefulWidget {
  const TravelTabPage({super.key, this.travelUrl, this.groupChannelCode = ''});

  final String? travelUrl;
  final String groupChannelCode;

  @override
  _TravelTabPageState createState() => _TravelTabPageState();
}

class _TravelTabPageState extends State<TravelTabPage> with AutomaticKeepAliveClientMixin {
  List<TravelItem?>? travelItems = [];
  int pageIndex = 1;
  bool _isLoading = true;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _loadData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _loadData(loadMore: true);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingContainer(
        isLoading: _isLoading,
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: StaggeredGridView.countBuilder(
                controller: _scrollController,
                crossAxisCount: 4,
                itemCount: travelItems?.length ?? 0,
                itemBuilder: (BuildContext context, int index) => _TravelItem(
                  item: travelItems![index],
                  index: index,
                ),
                staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
              )),
        ),
      )
    );
  }

  Future<Null> _handleRefresh() async {
    _loadData();
    return null;
  }

  void _loadData({ loadMore = false}) async {
    if (loadMore) {
      pageIndex++;
    } else {
      pageIndex = 1;
    }
    try {
      TravelDao.fetch(widget.travelUrl ?? travelUrl, widget.groupChannelCode, pageIndex, pageSize).then((TravelModel model) {
        _isLoading = false;
        setState(() {
          List<TravelItem> items = _filterItems(model.resultList);
          if (travelItems != null) {
            travelItems!.addAll(items);
          } else {
            travelItems = items;
          }
        });
      });
    } catch (e) {
      _isLoading = false;
      print(e);
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

List<TravelItem> _filterItems(List<TravelItem?>? resultList) {
  if (resultList == null) {
    return [];
  }
  List<TravelItem> filterItems = [];
  for (var item in resultList) {
    if (item?.article != null) {
      filterItems.add(item!);
    }
  }
  return filterItems;
}

class _TravelItem extends StatelessWidget {
  final TravelItem? item;
  final int index;

  const _TravelItem({Key? key, this.item, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(item?.article?.urls != null && item!.article!.urls!.length > 0) {
          Navigator.pushNamed(context, '/travel_detail', arguments: {'url': item!.article!.urls![0]?.h5Url});
        }
      },
      child: Card(
        child: PhysicalModel(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _itemImage(),
              Container(
                padding: const EdgeInsets.all(4),
                child: Text(
                  item?.article?.articleTitle ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
              _infoText()
            ],
          ),
        ),
      ),
    );
  }

  _itemImage() {
    return Stack(
      children: <Widget>[
        Image.network(
          item?.article?.images?[0]?.dynamicUrl ?? '',
          fit: BoxFit.cover,
          width: double.infinity,
          height: 220,
        ),
        Positioned(
          bottom: 8,
          left: 8,
          child: Container(
            padding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
            decoration: const BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomRight: Radius.circular(5)
              )
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 3),
                  child: Icon(Icons.location_on, color: Colors.white, size: 12),
                ),
                LimitedBox(
                  maxWidth: 130,
                  child: Text(
                    _poiName(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  _infoText() {
    return Container(
      padding: const EdgeInsets.fromLTRB(6, 0, 6, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              PhysicalModel(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  item?.article?.author?.coverImage?.dynamicUrl ?? '',
                  width: 24,
                  height: 24,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                width: 90,
                child: Text(
                  item?.article?.author?.nickName ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
          Row(
            children: [
              Icon(Icons.thumb_up, size: 14, color: Colors.grey),
              Container(
                padding: const EdgeInsets.all(5),
                width: 30,
                child: Text(
                  item?.article?.likeCount.toString() ?? '',
                  style: const TextStyle(fontSize: 10),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  _poiName() {
    return item?.article?.poiName ?? '未知';
  }
}