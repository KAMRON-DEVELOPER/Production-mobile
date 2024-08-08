import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/profile/profile_event.dart';
import 'package:mobile/utilities/validator.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../bloc/profile/profile_state.dart';
import '../../widgets/drawer_widget.dart';
import '../../widgets/image_selector.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Uint8List? _croppedImage;

  void _showImageSelector() {
    showImageSelector(context, 140, 140, (croppedImage) {
      setState(() {
        _croppedImage = croppedImage;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int screenWidth = constraints.maxWidth.floor();
        int screenHeight = constraints.maxHeight.floor();
        double avatarSize = screenWidth * 0.32;
        return buildDrawerWidget(
          context: context,
          appBarTitle: 'Home screen',
          content: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: BlocConsumer<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state is ProfileStateLoading) {
                  print('LISTENER ProfileStateLoading');
                  if (state.mustRebuild == true) {
                    print("LISTENER MUST REBUILD");
                    context.read<ProfileBloc>().add(GetProfileEvent());
                  }
                } else if (state is ProfileStateSuccess) {
                  print(
                      'LISTENER ProfileStateSuccess ${state.profileData?.username}');
                } else if (state is ProfileStateFailure) {
                  print(
                    'LISTENER ProfileStateFailure ${state.profileFailureMessage}',
                  );
                }
              },
              builder: (context, state) {
                if (state is ProfileStateSuccess) {
                  String? username = state.profileData?.username;
                  String? email = state.profileData?.email;
                  String? bio = state.profileData?.bio;
                  return Container(
                    padding: const EdgeInsets.only(top: 40),
                    height: screenHeight.toDouble() - 64 - 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.yellow,
                        width: 0.2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (_croppedImage != null)
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: MemoryImage(_croppedImage!),
                                fit: BoxFit.cover,
                                isAntiAlias: true,
                              ),
                            ),
                          )
                        else
                          const Text("No image selected"),
                        // Todo: Avatar
                        CircleAvatar(
                          backgroundColor: Colors.red.withOpacity(0.3),
                          radius: 0.5 * avatarSize,
                          child: CachedNetworkImage(
                            imageUrl:
                                "http://192.168.31.42:8000${state.profileData?.photo}",
                            fit: BoxFit.cover,
                            height: avatarSize.doubleCacheSize(context),
                            width: avatarSize.doubleCacheSize(context),
                            memCacheHeight: avatarSize.cacheSize(context),
                            memCacheWidth: avatarSize.cacheSize(context),
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    isAntiAlias: true,
                                  ),
                                ),
                              );
                            },
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) {
                              return Icon(
                                Icons.error,
                                size: avatarSize,
                              );
                            },
                          ),
                        ),
                        Text(
                          username!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          email!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          bio!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _showImageSelector,
                          child: const Text("upload photo"),
                        ),
                      ],
                    ),
                  );
                } else if (state is ProfileStateLoading) {
                  print(
                      "message in ProfileStateLoading >> ${state.mustRebuild}");
                  return const CircularProgressIndicator();
                } else if (state is ProfileStateFailure) {
                  print(
                      "message in profileFailure >> ${state.profileFailureMessage}");
                  return Text(
                    state.profileFailureMessage,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 36,
                    ),
                  );
                } else {
                  return const Text(
                    'Unexpected state',
                    style: TextStyle(
                      color: Colors.purpleAccent,
                      fontSize: 12,
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
