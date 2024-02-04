
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:music_player_miao/common_widget/app_data.dart';
import '../api/api_release.dart';
import '../models/universal_bean.dart';
import '../widget/text_field.dart';

class ReleaseView extends StatefulWidget {
  const ReleaseView({Key? key});

  @override
  State<ReleaseView> createState() => _ReleaseViewState();
}

class SongInfo {
  String songName;
  String artistName;

  SongInfo({required this.songName, required this.artistName});
}

class _ReleaseViewState extends State<ReleaseView> {

  List<File> coverImages = [];
  List<SongInfo> songInfoList = [];

  late File selectedMp3File;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/app_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child:
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  ///立即发布
                  const Center(
                    child: Text(
                      "立即发布",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  ///上传文件upload
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            _showUploadDialog();
                          },
                          icon: Image.asset("assets/img/release_upload.png", width: 45,),
                        ),
                        const Text(
                          "上传文件",
                          style: TextStyle(
                              fontSize: 20
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 30,),
                ],
              ),
              ///音乐列表
              const Text(
                "音乐列表",
                style: TextStyle(
                    fontSize: 20
                ),
              ),
              const SizedBox(height: 20,),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child:
                  coverImages.isEmpty
                      ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: const Center(
                      child: Text(
                        "目前还是空的",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  )
                      :
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(songInfoList.length, (index) {
                      return ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: coverImages[index] != null
                                      ? Image.file(
                                    coverImages[index]!,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  )
                                      : Container(
                                    color: const Color(0xffC4C4C4),
                                    width: 60,
                                    height: 60,
                                  ),
                                ),
                                const SizedBox(width: 20,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      songInfoList[index].songName,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    Text(songInfoList[index].artistName),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                _bottomSheet(context, index);
                              },
                              icon: Image.asset(
                                "assets/img/More.png",
                                width: 25,
                                height: 25,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _bottomSheet(BuildContext context, int index) async {
    await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        builder: (context) => Container(
          height: 200,
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
                        onPressed: () {
                          _editSongInformation(context, index);
                        },
                        icon: Image.asset("assets/img/release_info.png"),
                        iconSize: 60,
                      ),
                      const Text("编辑歌曲信息")
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          _confirmDelete(context, index);
                        },
                        icon: Image.asset("assets/img/release_delete.png"),
                        iconSize: 60,
                      ),
                      const Text("删除")
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30,),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "取消",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff429482),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

  ///编辑信息
  void _editSongInformation(BuildContext context, int index) {
    TextEditingController songNameController = TextEditingController();
    TextEditingController artistNameController = TextEditingController();

    songNameController.text = songInfoList[index].songName;
    artistNameController.text = songInfoList[index].artistName;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: const Center(child: Text('编辑歌曲信息')),
        content: SizedBox(
          height: 260,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("封面"),
                  IconButton(
                    onPressed: () {
                      _getImageFromGallery(index);
                    },
                    icon: coverImages[index] != null
                        ? Image.file(
                      coverImages[index]!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                        : Image.asset(
                      "assets/img/release_pic1.png",
                      width: 60,
                      height: 60,
                    ),
                    iconSize: 60,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text("歌名"),
              TextFieldColor(
                  controller: songNameController,
                  hintText: '请输入歌曲名称'
              ),
              const SizedBox(height: 20,),
              const Text("歌手"),
              TextFieldColor(
                  controller: artistNameController,
                  hintText: '请输入歌手名称'
              ),
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
              // Handle the edited song information here
              String editedSongName = songNameController.text;
              String editedArtistName = artistNameController.text;

              // Update the song information in your data structure
              songInfoList[index] = SongInfo(
                songName: editedSongName,
                artistName: editedArtistName,
              );

              // For demonstration, print the edited values
              print('Edited Song Name: $editedSongName');
              print('Edited Artist Name: $editedArtistName');

              // Update the displayed song information in the UI
              setState(() {});
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xff429482),
              minimumSize: const Size(130, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            child: const Text('确认', style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }

  ///上传
  Future<void> _showUploadDialog() async {
    TextEditingController songNameController = TextEditingController();
    TextEditingController artistNameController = TextEditingController();

    // Set default values for song and artist names
    songNameController.text = '未知歌曲';
    artistNameController.text = '未知歌手';

    File selectedCoverImage  = File('');

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius:BorderRadius.circular(10),
        ),
        title: const Center(child: Text('上传文件')),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('文件'),
                IconButton(
                  onPressed: () async {
                    selectedMp3File = (await _getMp3File())!;
                  },
                  icon: Image.asset(
                    "assets/img/release_download1.png",
                    width: 60,
                    height: 60,
                  ),
                  iconSize: 60,
                ),
              ],
            ),
            // const SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text("封面"),
                IconButton(
                  onPressed: () async {
                    selectedCoverImage = (await _getImageFromGallery())!;
                  },
                  icon: Image.asset(
                    "assets/img/release_pic1.png",
                    width: 60,
                    height: 60,
                  ),
                  iconSize: 60,
                ),
              ],
            ),

            // const SizedBox(height: 10),
            const Text(
              '歌名',
            ),
            TextFieldColor(
                controller: songNameController,
                hintText: '输入歌曲名称'
            ),
            // const SizedBox(height: 10),
            const Text(
              '歌手',
            ),
            TextFieldColor(
                controller: artistNameController,
                hintText: '输入歌手名称'
            ),
          ],
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
            onPressed: () async {
              String enteredSongName = songNameController.text;
              String enteredArtistName = artistNameController.text;

              if (selectedCoverImage != null && selectedMp3File != null) {
                coverImages.add(selectedCoverImage);
                songInfoList.add(SongInfo(
                  songName: enteredSongName,
                  artistName: enteredArtistName,
                ));
                UniversalBean bean = await ReleaseApi().release(
                    coverFile:selectedCoverImage,
                    musicFile: selectedMp3File!,
                    Authorization: AppData().currentToken,
                    singerName: enteredArtistName,
                    name: enteredSongName,
                    introduce: '0');
                Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius:BorderRadius.circular(10),
                      ),
                      title: Image.asset("assets/img/correct.png",width: 47,height: 46,),
                      content: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('提交审核成功'),
                          Text('审核通过后自动发布'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xff429482),
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0), // Adjust the radius as needed
                            ),
                          ),
                          child: const Text('确认',style: TextStyle(color: Colors.white),),
                        ),
                      ],
                    ),
                  );
                }
              },

            style: TextButton.styleFrom(
              backgroundColor: const Color(0xff429482),
              minimumSize: const Size(130, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            child: const Text('确认', style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }


  Future<File?> _getImageFromGallery([int? index]) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        if (index != null && index < coverImages.length) {
          coverImages[index] = File(pickedFile.path);
        } else {
          coverImages.add(File(pickedFile.path));
        }
      });
      return File(pickedFile.path);
    }

    return null;
  }
  Future<File> _getMp3File() async {
    final filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3'],
    );

    if (filePickerResult != null && filePickerResult.files.isNotEmpty) {
      return File(filePickerResult.files.first.path!);
    }

    return File('');
  }

  void _confirmDelete(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius:BorderRadius.circular(10),
        ),
        title: Image.asset("assets/img/warning.png",width: 47,height: 46,),
        content: const Text('确认删除？',textAlign: TextAlign.center,),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xff429482),
              minimumSize: const Size(130, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            child: const Text('取消',style: TextStyle(color: Colors.white),),
          ),
          TextButton(
            onPressed: () {
              // Remove the selected song from the lists
              setState(() {
                coverImages.removeAt(index);
                songInfoList.removeAt(index);
              });
              Navigator.pop(context); // Close the dialog
            },
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xff429482),
              minimumSize: const Size(130, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            child: const Text('确认',style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }

}