import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/profile/profile_event.dart';
import 'package:mobile/utilities/validator.dart';
import 'package:provider/provider.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../bloc/profile/profile_state.dart';
import '../../provider/network_provider.dart';
import '../../provider/theme_provider.dart';
import '../../widgets/drawer_widget.dart';
import '../../widgets/top_snack_bar.dart';

class HomeScreen extends StatelessWidget {
  final ConnectivityProvider? connectionStatus = ConnectivityProvider();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isOnline = false;
    ConnectivityProvider connectivityProvider =
        Provider.of<ConnectivityProvider>(context);
    isOnline = connectivityProvider.status == 'Online';
    final theme = Provider.of<ThemeProvider>(context).currentTheme;

    return LayoutBuilder(builder: (context, constraints) {
      int screenWidth = constraints.maxWidth.floor();
      int screenHeight = constraints.maxHeight.floor();
      double avatarBackSize = screenWidth * 0.32;
      double avatarSize = screenWidth * 0.32;
      double divide = screenWidth * 0.04;
      return buildDrawerWidget(
        context: context,
        appBarTitle: 'Home screen',
        content: RefreshIndicator(
          onRefresh: () async {
            print("REFRESH...");
            if (isOnline) {
              context.read<ProfileBloc>().add(GetProfileEvent());
            } else {
              showTopSnackBar(
                context: context,
                message: "you aren't connected to internet!",
                backgroundColor: Colors.red,
                duration: const Duration(milliseconds: 3000),
              );
            }
            return await Future.delayed(const Duration(seconds: 1));
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: BlocConsumer<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state is ProfileStateLoading) {
                  print('loading listener **** ()');
                  if (state.mustRebuild == true) {
                    print("must rebuild **** ture");
                    context.read<ProfileBloc>().add(GetProfileEvent());
                  }
                } else if (state is ProfileStateSuccess) {
                  print('success listener **** ${state.profileData.username}');
                  showTopSnackBar(
                    context: context,
                    message: "profileData successfully loaded",
                    backgroundColor: Colors.green,
                    duration: const Duration(milliseconds: 3000),
                  );
                } else if (state is ProfileStateFailure) {
                  print('failure listener **** ${state.profileFailureMessage}');
                  showTopSnackBar(
                    context: context,
                    message: "Failed while fetching profileData",
                    backgroundColor: Colors.red,
                    duration: const Duration(milliseconds: 3000),
                  );
                }
              },
              builder: (context, state) {
                print('<<<<<<<< BUILDER >>>>>>>');
                print("screenWidth >> $screenWidth");
                print("screenHeight >> $screenHeight");
                if (state is ProfileStateLoading) {
                  print('STATE IN BUILDER >>>> ${state.mustRebuild}');
                  if (isOnline) {
                    context.read<ProfileBloc>().add(GetProfileEvent());
                  } else {
                    context.read<ProfileBloc>().add(GetCacheProfileEvent());
                  }
                  return const CircularProgressIndicator();
                } else if (state is ProfileStateSuccess) {
                  return Container(
                    padding: const EdgeInsets.only(top: 40),
                    height: MediaQuery.of(context).size.height,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.yellow,
                        width: 0.2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // background
                            Container(
                              constraints: BoxConstraints.expand(
                                height: avatarBackSize,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.green,
                                  width: 0.2,
                                ),
                              ),
                              child: Image.asset(
                                "assets/images/gnome.jpg",
                                fit: BoxFit.cover,
                                height: avatarBackSize,
                                cacheHeight: avatarBackSize.cacheSize(context),
                                isAntiAlias: true,
                              ),
                            ),

                            // avatar
                            Positioned.fromRect(
                              rect: Rect.fromPoints(
                                Offset(
                                  divide,
                                  avatarBackSize - avatarSize / 2,
                                ),
                                Offset(
                                  divide + avatarSize,
                                  avatarBackSize + avatarSize / 2,
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: theme.background2,
                                    width: screenWidth * 0.01,
                                  ),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "http://192.168.31.42:8000${state.profileData.photo}",
                                    memCacheHeight:
                                        avatarSize.cacheSize(context),
                                    memCacheWidth:
                                        avatarSize.cacheSize(context),
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                          isAntiAlias: true,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.error,
                                      size: avatarSize,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // analytics
                            Positioned.fromRect(
                              rect: Rect.fromPoints(
                                Offset(
                                  2 * divide + avatarSize,
                                  avatarBackSize,
                                ),
                                Offset(
                                  screenWidth * 0.96,
                                  avatarBackSize + avatarSize / 2,
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.pink,
                                    width: 0.05,
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "12",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            height: 1,
                                          ),
                                        ),
                                        Text(
                                          "posts",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "34k",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            height: 1,
                                          ),
                                        ),
                                        Text(
                                          "followers",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "54",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            height: 1,
                                          ),
                                        ),
                                        Text(
                                          "following",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // full name && email
                            Positioned.fromRect(
                              rect: Rect.fromPoints(
                                Offset(
                                  screenWidth * 0.04,
                                  avatarBackSize + avatarSize / 2 + divide,
                                ),
                                Offset(
                                  screenWidth * 0.96,
                                  avatarBackSize +
                                      avatarSize / 2 +
                                      1.5 * divide +
                                      screenWidth * 0.09,
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.pink,
                                    width: 0.05,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${state.profileData.fullName}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.05,
                                        height: 1,
                                      ),
                                    ),
                                    Text(
                                      "@${state.profileData.username}",
                                      style: TextStyle(
                                        color: Colors.blue.withOpacity(0.9),
                                        fontSize: screenWidth * 0.04,
                                        height: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 150),
                        Container(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Text(
                            "${state.profileData.bio}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is ProfileStateFailure) {
                  return Text(
                    state.profileFailureMessage,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
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
        ),
      );
    });
  }
}

/*
Consumer<ConnectivityProvider>(
builder: (context, connectivityProvider, child) {
isOnline = connectivityProvider.status == 'Online';
return Text(
connectivityProvider.status,
style: TextStyle(
fontSize: 18,
color: connectivityProvider.status == 'Offline'
? Colors.red
    : Colors.green,
),
);
},
),
*/
