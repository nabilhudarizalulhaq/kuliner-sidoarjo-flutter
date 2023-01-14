import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kulineran/data/repository/user_repository.dart';
import 'package:kulineran/module/filter/filter_bloc.dart';
import 'package:kulineran/utils/widget/progress_loading_view.dart';
import 'package:kulineran/data/model/sub_district_model.dart' as subDistrictModel;

class FilterView extends StatefulWidget {
  const FilterView({Key? key}) : super(key: key);

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {

  FilterBloc? filterBloc;

  @override
  void initState() {
    filterBloc = FilterBloc ( RepositoryProvider.of<UserRepository>(context), );
    filterBloc?.add(GetSubDistrictEvent());
    super.initState();
  }

  Widget _buildSubDistrictList(List<subDistrictModel.Data> listSubDistrict) {
    return listSubDistrict.length > 0 ? ListView.builder(
        itemCount: listSubDistrict.length,
        itemBuilder: (context, position) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(12),
                  child: Text(
                    listSubDistrict[position].name,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87
                    ),
                  ),
                ),
                onTap: (){
                  print('subDistrict ${listSubDistrict[position].name} ${listSubDistrict[position].id}');
                  filterBloc?.add(AddFilterEvent(
                      listSubDistrict[position].id.toString(),
                      listSubDistrict[position].name,
                      false
                  ));
                },
              ),
              Container( color: Colors.black12, height: 0.5 )
            ],
          );
        }
    ): Container();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => filterBloc!,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: new IconButton(
              icon: new Icon(Icons.close, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            title: Text(
                'Filter Kecamatan',
              style: TextStyle(
                color: Colors.black
              ),
            ),
          ),
          body: BlocConsumer<FilterBloc, FilterState> (
            listener: (context, state) {
              if(state is SubDistrictLoaded) {
                state.subDistrictModel.data.forEach((element) {
                  // print('subDistrictModel: data ${element.name}');
                });
              } else if (state is FilterAdded) {
                Navigator.of(context).pop(true);
              }
            },
            builder: (context, state) {
              if(state is SubDistrictLoading) {
                return ProgressLoadingView();
              } else if (state is SubDistrictLoaded) {
                return _buildSubDistrictList(state.subDistrictModel.data);
              }
              return Container();
            },
          )
      ),
    );
  }
}
