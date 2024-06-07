import 'dart:math';

import 'package:flutter/animation.dart';

class User {
  final String name;
  final int age;
  final String videoUrl;
  final String location;
  final String imageUrl;
  bool liked = false;

  User({
    required this.name,
    required this.age,
    required this.videoUrl,
    required this.imageUrl,
    required this.location,
    this.liked = false,
  });
}

const kDefaultAnimationDuration = Duration(milliseconds: 800);
const kDefaultAnimationCurve = Curves.easeIn;

final List<User> usersList = [
  User(
    name: "Arthur Smith",
    age: 25,
    videoUrl:
        "https://videos.pexels.com/video-files/2795401/2795401-sd_540_960_25fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/1577009/pexels-photo-1577009.jpeg?auto=compress&cs=tinysrgb&w=200',
    location: "Phoenix, USA",
  ),
  User(
    name: "Courtney Brown",
    age: 30,
    videoUrl:
        "https://videos.pexels.com/video-files/2791669/2791669-sd_540_960_25fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/775358/pexels-photo-775358.jpeg?auto=compress&cs=tinysrgb&w=200',
    location: "New York, USA",
  ),
  User(
    name: "Arthur Jones",
    age: 22,
    videoUrl:
        "https://videos.pexels.com/video-files/4434136/4434136-sd_540_960_30fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/1858175/pexels-photo-1858175.jpeg?auto=compress&cs=tinysrgb&w=200',
    location: "Los Angeles, USA",
  ),
  User(
    name: "Arthur Williams",
    age: 28,
    videoUrl:
        "https://videos.pexels.com/video-files/4650486/4650486-hd_720_1366_30fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/1577012/pexels-photo-1577012.jpeg?auto=compress&cs=tinysrgb&w=200',
    location: "Chicago, USA",
  ),
  User(
    name: "Courtney Taylor",
    age: 27,
    videoUrl:
        "https://videos.pexels.com/video-files/5353260/5353260-sd_540_960_25fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/1577013/pexels-photo-1577013.jpeg?auto=compress&cs=tinysrgb&w=200',
    location: "Houston, USA",
  ),
  User(
    name: "Arthur Lee",
    age: 24,
    videoUrl:
        "https://videos.pexels.com/video-files/8044824/8044824-sd_540_960_25fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/1577014/pexels-photo-1577014.jpeg?auto=compress&cs=tinysrgb&w=200',
    location: "San Diego, USA",
  ),
  User(
    name: "Arthur Clark",
    age: 32,
    videoUrl:
        "https://videos.pexels.com/video-files/8233934/8233934-hd_720_1366_25fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/1577015/pexels-photo-1577015.jpeg?auto=compress&cs=tinysrgb&w=200',
    location: "Austin, USA",
  ),
  User(
    name: "Courtney Walker",
    age: 29,
    videoUrl:
        "https://videos.pexels.com/video-files/7505763/7505763-sd_540_960_30fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/1577016/pexels-photo-1577016.jpeg?auto=compress&cs=tinysrgb&w=200',
    location: "Dallas, USA",
  ),
  User(
    name: "Arthur Harris",
    age: 21,
    videoUrl:
        "https://videos.pexels.com/video-files/6586074/6586074-sd_540_960_30fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/1362724/pexels-photo-1362724.jpeg?auto=compress&cs=tinysrgb&w=200',
    location: "San Francisco, USA",
  ),
  User(
    name: "Arthur Lewis",
    age: 35,
    videoUrl:
        "https://videos.pexels.com/video-files/6799742/6799742-sd_540_960_30fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/2007647/pexels-photo-2007647.jpeg?auto=compress&cs=tinysrgb&w=200',
    location: "Seattle, USA",
  ),
  User(
    name: "Courtney Hall",
    age: 23,
    videoUrl:
        "https://videos.pexels.com/video-files/8588877/8588877-hd_720_1366_25fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/3304341/pexels-photo-3304341.jpeg?auto=compress&cs=tinysrgb&w=200',
    location: "Boston, USA",
  ),
  User(
    name: "Arthur Queen",
    age: 26,
    videoUrl:
        "https://videos.pexels.com/video-files/4990426/4990426-sd_540_960_30fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/1758144/pexels-photo-1758144.jpeg?auto=compress&cs=tinysrgb&w=200',
    location: "Denver, USA",
  ),
  User(
    name: "Arthur Wright",
    age: 33,
    videoUrl:
        "https://videos.pexels.com/video-files/7550765/7550765-sd_540_960_30fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/1755385/pexels-photo-1755385.jpeg?auto=compress&cs=tinysrgb&w=200',
    location: "Las Vegas, USA",
  ),
  User(
    name: "Courtney Scott",
    age: 20,
    videoUrl:
        "https://videos.pexels.com/video-files/7302975/7302975-sd_540_960_25fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/4009599/pexels-photo-4009599.jpeg?auto=compress&cs=tinysrgb&w=200',
    location: "Miami, USA",
  ),
  User(
    name: "Arthur Adams",
    age: 31,
    videoUrl:
        "https://videos.pexels.com/video-files/4936970/4936970-sd_540_960_24fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/1577026/pexels-photo-1577026.jpeg?auto=compress&cs=tinysrgb&w=200',
    location: "Orlando, USA",
  ),
  User(
    name: "Arthur Nelson",
    age: 34,
    videoUrl:
        "https://videos.pexels.com/video-files/4835063/4835063-sd_540_960_30fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/3027243/pexels-photo-3027243.jpeg?auto=compress&cs=tinysrgb&w=200',
    location: "Atlanta, USA",
  ),
  User(
    name: "Courtney Carter",
    age: 19,
    videoUrl:
        "https://videos.pexels.com/video-files/4759582/4759582-sd_540_960_30fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/1577025/pexels-photo-1577025.jpeg?auto=compress&cs=tinysrgb&w=200',
    location: "Portland, USA",
  ),
  User(
    name: "Arthur Mitchell",
    age: 36,
    videoUrl:
        "https://videos.pexels.com/video-files/2791956/2791956-sd_540_960_25fps.mp4",
    imageUrl:
        'https://images.pexels.com/photos/1183266/pexels-photo-1183266.jpeg?auto=compress&cs=tinysrgb&w=200',
    location: "Philadelphia, USA",
  ),
];

const List<String> gamesList = [
  'https://cdn1.epicgames.com/offer/046aeb7098b94ac3961dad6c5dbe68c0/EGS_RatchetClankRiftApart_InsomniacGames_S2_1200x1600-52110dae5ab01644738dac07ac1ea796?h=480&quality=medium&resize=1&w=360',
  'https://cdn1.epicgames.com/salesEvent/salesEvent/Daffodil_1P_Awareness_INT_Epic_1200x1600_1200x1600-356dd4965bde4c5dbd1000f9c97ac4b4?h=480&quality=medium&resize=1&w=360',
  'https://cdn1.epicgames.com/spt-assets/04d5b86a93514949a3ace614d9e1e417/witchfire-obly4.jpg?h=480&quality=medium&resize=1&w=360',
  'https://cdn1.epicgames.com/offer/fda0f2b4047f46ffb4e94d5595c1468e/EGS_MortalKombat1_NetherRealmStudios_S4_1200x1600-076e67292bb57f11ebb4465b7e74a65e?h=480&quality=medium&resize=1&w=360',
  'https://cdn1.epicgames.com/offer/4ec958d5e4b6429aadbc116cee0b6ea0/EGS_DeadSpace_MotiveStudio_S2_1200x1600-551c16d068cab45b02149e15a43c2413?h=480&quality=medium&resize=1&w=360',
  'https://cdn1.epicgames.com/offer/8b2d6cf2b45b41f1abe91bc5b7c1e8f9/EGS_UNCHARTEDLegacyofThievesCollection_NaughtyDogLLC_S2_1200x1600-9deaa177d8716bde5478cdd75d850c9c?h=480&quality=medium&resize=1&w=360',
  'https://cdn1.epicgames.com/spt-assets/56420acb023b4f9597401dc2c5ea9352/lords-of-the-fallen-1y68x.jpg?h=480&quality=medium&resize=1&w=360',
  'https://cdn1.epicgames.com/offer/aa598567414d42378187b8861da550f7/EGS_RemnantII_GunfireGames_S2_1200x1600-3365edad94b9306bc1e275bc7f4dd7d5?h=480&quality=medium&resize=1&w=360',
  'https://cdn1.epicgames.com/offer/22600f09e936468c8ecfc22b5eac7d7c/EGST_StorePortrait_1200x1600_1200x1600-54fe39c69e335bbe2c071ff53cfa0685?h=480&quality=medium&resize=1&w=360',
  'https://cdn1.epicgames.com/offer/f696430be718494fac1d6542cfb22542/EGS_MarvelsSpiderManMilesMorales_InsomniacGamesNixxesSoftware_S2_1200x1600-58989e7116de3f70a2ae6ea56ee202c6?h=480&quality=medium&resize=1&w=360',
  'https://cdn1.epicgames.com/400347196e674de89c23cc2a7f2121db/offer/AC%20KINGDOM%20PREORDER_STANDARD%20EDITION_EPIC_Key_Art_Portrait_640x854-640x854-288120c5573756cb988b6c1968cebd86.png?h=480&quality=medium&resize=1&w=360',
  'https://cdn1.epicgames.com/offer/9533b9db84274b15886caa464445a975/EGST_StorePortrait_1200x1600_1200x1600-4e8995358cccb9b278b7556651242032?h=480&quality=medium&resize=1&w=360',
  'https://cdn1.epicgames.com/offer/76cd63399a874c2b854fd74cda49a256/EGS_SuicideSquadKilltheJusticeLeague_RocksteadyStudios_S2_1200x1600-de19e59d88cabce5d7767cbf12acf504?h=480&quality=medium&resize=1&w=360',
  'https://cdn1.epicgames.com/offer/4bc43145bb8245a5b5cc9ea262ffbe0e/EGS_MarvelsSpiderManRemastered_InsomniacGamesNixxesSoftware_S2_1200x1600-76424286902489f4d9639ac9b735c2b2?h=480&quality=medium&resize=1&w=360',
  'https://cdn1.epicgames.com/offer/0c40923dd1174a768f732a3b013dcff2/EGS_TheLastofUsPartI_NaughtyDogLLC_S2_1200x1600-41d1b88814bea2ee8cb7986ec24713e0?h=480&quality=medium&resize=1&w=360',
  'https://cdn1.epicgames.com/offer/3ddd6a590da64e3686042d108968a6b2/EGS_GodofWar_SantaMonicaStudio_S2_1200x1600-fbdf3cbc2980749091d52751ffabb7b7_1200x1600-fbdf3cbc2980749091d52751ffabb7b7?h=480&quality=medium&resize=1&w=360',
  'https://cdn1.epicgames.com/offer/0c05e0889c3e42a4be1d81077d6e653a/SAB_Store_Portrait_1200x1600_1200x1600-121f3de29b692d333e0773c7d4a7a432?h=480&quality=medium&resize=1&w=360',
  'https://cdn1.epicgames.com/spt-assets/7dbdd3c2a72e4cbaacc166a884031882/expeditions--a-mudrunner-game-2zlf2.jpg?h=480&quality=medium&resize=1&w=360',
  'https://cdn1.epicgames.com/spt-assets/2ae760629a384d5199cbefc612db7ac8/the-lord-of-the-rings-return-to-moria-tr0c9.png?h=480&quality=medium&resize=1&w=360',
  'https://cdn1.epicgames.com/offer/77f2b98e2cef40c8a7437518bf420e47/EGS_Cyberpunk2077UltimateEdition_CDPROJEKTRED_Editions_S2_1200x1600-81442c61fd09b45ecd03add7c0c3afdd?h=480&quality=medium&resize=1&w=360',
  'https://cdn1.epicgames.com/offer/236c74b4cd2e4e3099cbe2ebdc9686fd/EGS_DeadIsland2_DeepSilverDambusterStudios_S2_1200x1600-efc5201842cf642eb45f73227cd0789b?h=480&quality=medium&resize=1&w=360',
  'https://cdn1.epicgames.com/0584d2013f0149a791e7b9bad0eec102/offer/GTAV_EGS_Artwork_1200x1600_Portrait%20Store%20Banner-1200x1600-382243057711adf80322ed2aeea42191.jpg?h=480&quality=medium&resize=1&w=360',
  'https://cdn1.epicgames.com/epic/offer/RDR2PC1227_Epic%20Games_860x1148-860x1148-b4c2210ee0c3c3b843a8de399bfe7f5c.jpg?h=480&quality=medium&resize=1&w=360',
  'https://cdn1.epicgames.com/offer/c4763f236d08423eb47b4c3008779c84/EGS_AlanWake2_RemedyEntertainment_S2_1200x1600-c7c8091ddac0f9669c8e5905bca88aaa?h=480&quality=medium&resize=1&w=360',
  'https://cdn1.epicgames.com/offer/4750c68b2bfa4f43933b81cfd5cc510c/EGS_EASPORTSFC24StandardEdition_EACanada_S2_1200x1600-37aa3816ed46542836e1068060998810?h=480&quality=medium&resize=1&w=360',
];
