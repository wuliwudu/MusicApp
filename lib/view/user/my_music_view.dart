
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view_model/home_view_model.dart';

class MyMusicView extends StatefulWidget {
  const MyMusicView({super.key});

  @override
  State<MyMusicView> createState() => _MyMusicViewState();
}

class _MyMusicViewState extends State<MyMusicView> {

  final listVM = Get.put(HomeViewModel());
  bool _isSelectMode = false;
  final List<bool> _mySongListSelections = List.generate(2, (index) => false);
  List<bool> _selectedItems = List.generate(10, (index) => false);

  void _toggleSelectMode() {
    setState(() {
      _isSelectMode = !_isSelectMode;
      if (!_isSelectMode) {
        _selectedItems = List.generate(10, (index) => false);
      }
    });
  }

  void _selectAll() {
    setState(() {
      _selectedItems = List.generate(10, (index) => true);
    });
  }

  void _showSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius:BorderRadius.circular(10),
          ),
          title: Row(
            children: [
              const Text("添加到",),
              Text(
                  '(${_selectedItems.where((item) => item).length} 首)',
                style: const TextStyle(
                  color: Color(0xff429482),
                  fontSize: 16
                ),
              )
            ],
          ),
          content:SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                for (int i = 0; i < _mySongListSelections.length; i++)
                  _buildSongListTile(i),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xff429482),
                minimumSize: const Size(130, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              child: const Text(
                "取消",
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xff429482),
                minimumSize: const Size(130, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              child: const Text(
                "保存",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSongListTile(int index) {
    return ListTile(
      title: Text("我的歌单 $index"),
      trailing: Checkbox(
        value: _mySongListSelections[index],
        onChanged: (value) {
          setState(() {
            _mySongListSelections[index] = value ?? false;
          });
        },
        shape: const CircleBorder(),
        activeColor: const Color(0xff429482),
      ),
      onTap: () {
        setState(() {
          _mySongListSelections[index] = !_mySongListSelections[index];
        });
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/img/app_bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          leading: !_isSelectMode
              ?IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Image.asset(
              "assets/img/back.png",
              width: 25,
              height: 25,
              fit: BoxFit.contain,
            ),
          )
              : TextButton(
            onPressed: _selectAll,
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
            child: const Text('全选',style: TextStyle(fontSize: 18),),
          ),
          title: _isSelectMode
              ? Text(
                '已选中 ${_selectedItems.where((item) => item).length} 首歌曲',
                style: const TextStyle(
                  color: Colors.black,
                ),
              )
              : const Text(
            '我的歌单',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            if (_isSelectMode)
              TextButton(
                  onPressed: (){
                    setState(() {
                      _isSelectMode = false;
                      _selectedItems = List.generate(10, (index) => false);
                    });
                  },
                  child: const Text(
                      "完成",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18
                    ),
                  )
              )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: (){},
                        icon: Image.asset(
                          "assets/img/button_play.png",
                          width: 20,
                          height: 20,
                        ),
                      ),
                      const Text(
                        '播放全部',
                        style: TextStyle(
                            fontSize: 16
                        ),
                      ),
                      const SizedBox(width: 5,),
                      const Text(
                        '50',
                        style: TextStyle(
                            fontSize: 16
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: _toggleSelectMode,
                    icon: Image.asset(
                      "assets/img/list_op.png",
                      width: 20,
                      height: 20,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: ListTile(
                        leading: _isSelectMode
                            ? Checkbox(
                          value: _selectedItems[index],
                          onChanged: (value) {
                            setState(() {
                              _selectedItems[index] = value!;
                            });
                          },
                          shape: const CircleBorder(),
                          activeColor: const Color(0xff429482),
                        )
                            : null,
                        title: Text('歌曲名 $index - 歌手'),
                        trailing: _isSelectMode
                            ? null
                            : IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {
                            _bottomSheet(context);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        bottomNavigationBar: _isSelectMode
            ? BottomAppBar(
          child: SizedBox(
            height: 127.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: (){
                            _showSelectionDialog();
                          },
                          icon: Image.asset("assets/img/list_add.png"),
                          iconSize: 60,
                        ),
                        const Text("添加到"),
                      ],
                    ),
                    Container(
                      height: 50,
                      width: 2,
                      color: const Color(0xff429482),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: (){},
                          icon: Image.asset("assets/img/list_download.png"),
                          iconSize: 60,
                        ),
                        const Text("下载"),
                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isSelectMode = false;
                      _selectedItems = List.generate(10, (index) => false);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff429482),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: const Text('取消',
                    style: TextStyle(
                    color: Colors.black,
                      fontSize: 16
                  ),),
                ),
              ],
            ),
          ),
        )
            : null,
      ),
    );
  }
  Future _bottomSheet(BuildContext context){
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        builder: (context) =>Container(
          height: 210,
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: (){},
                        icon: Image.asset("assets/img/list_remove.png"),
                        iconSize: 60,
                      ),
                      const Text("从歌单移除")
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: (){},
                        icon: Image.asset("assets/img/list_download.png"),
                        iconSize: 60,
                      ),
                      const Text("下载")
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: (){},
                        icon: Image.asset("assets/img/list_collection.png"),
                        iconSize: 60,
                      ),
                      const Text("收藏")
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: (){},
                        icon: Image.asset("assets/img/list_good.png"),
                        iconSize: 60,
                      ),
                      const Text("点赞")
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: (){},
                        icon: Image.asset("assets/img/list_comment.png"),
                        iconSize: 60,
                      ),
                      const Text("评论")
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () {
                  // Get.to(()=>const MusicView());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffE6F4F1),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: const Text(
                  "查看详情页",
                  style: TextStyle(color:Colors.black,fontSize: 18),
                ),

              ),
              ElevatedButton(
                onPressed: () =>Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff429482),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: const Text(
                  "取消",
                  style: TextStyle(color:Colors.black,fontSize: 18),
                ),

              ),
            ],
          ),
        )

    );
  }
}
