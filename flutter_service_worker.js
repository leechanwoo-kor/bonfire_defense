'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"manifest.json": "d3a5192f22c7ade9dc523ca2a8f9a5a4",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter_bootstrap.js": "6bd8f097b29aa4f69a146996effc73ab",
"version.json": "6e8548c37507a45ed0b78936ead3398c",
"index.html": "1c5e631dc5b0394e1ed7efa80d5b5d65",
"/": "1c5e631dc5b0394e1ed7efa80d5b5d65",
"main.dart.js": "1c1b0805774158a729f81702c2b3a326",
"assets/AssetManifest.json": "fc3ca71c761823d793241790069cabc7",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin.json": "f71ddf911293cf205904302f0175ef80",
"assets/fonts/MaterialIcons-Regular.otf": "ac956484d519e33e6980c12504019f2e",
"assets/assets/images/character/human-red.png": "540c5aa1fdc8eb797d6330f1ea9f0b23",
"assets/assets/images/character/human.png": "7e5d257d818a12a74dab746c59498440",
"assets/assets/images/character/orc.png": "ef92a9a0e913ae651d8faa0c0ef2da47",
"assets/assets/images/character/orc-armed.png": "93259e831c1b46afd56e17fa36027342",
"assets/assets/images/character/human-green.png": "e996ce9e21b77753963aaf977097563d",
"assets/assets/images/character/skeleton.png": "833dad6380eab01ec1996d1894712703",
"assets/assets/images/character/orc-red.png": "cdcfcf2e7470c748b506e7fd852601d1",
"assets/assets/images/icons/HeartFull.png": "0d07fa13d8b8a38ac5066828353934a8",
"assets/assets/images/icons/Coin.png": "3aad221156938e1ec86128b5d32d3912",
"assets/assets/images/icons/reroll.png": "6453de25fe5eae2ac3b2bd8caa6f7df4",
"assets/assets/images/icons/X.png": "21b9877a223a76ef6bd0d8e6fa73ddff",
"assets/assets/images/lancer.png": "6313eeda80b8b3996321b6c524f59cfb",
"assets/assets/images/map/Tiled/Tilemaps/Beginning%2520Fields.png": "f94278699207f0d1bc21c6828d4a4928",
"assets/assets/images/map/Tiled/Tilemaps/Beginning%2520Fields.tmj": "60649f8577cb0aa3eb47d39f5e637b6f",
"assets/assets/images/map/Tiled/Tilemaps/Beginning%2520Fields.js": "85781a862234b84a3609b4bacec379a9",
"assets/assets/images/map/Tiled/Tilemaps/rules.txt": "b2230550451d3b33c6f4c4434742649a",
"assets/assets/images/map/Tiled/Tilemaps/Beginning%2520Fields.tmx": "d0ec40bd76f519bcc9e563cc31e1fd75",
"assets/assets/images/map/Tiled/Tilesets/Animation_Flowers_White.tsj": "afecbd77ed25ada7e846e2bfd3d81506",
"assets/assets/images/map/Tiled/Tilesets/Atlas_Trees_Bushes.tsj": "b69798ba9e38ac1a4c28eb0276ed510d",
"assets/assets/images/map/Tiled/Tilesets/Objects_Rocks.tsj": "b334addf5f4ded2e1f26796569292689",
"assets/assets/images/map/Tiled/Tilesets/Tilesets_Road.tsj": "7922eb0382d18d56078c80d2bf67667a",
"assets/assets/images/map/Tiled/Tilesets/Atlas_Buildings.tsj": "9c5a7d1bd256f783e5f477100b71b5e4",
"assets/assets/images/map/Tiled/Tilesets/Objects_Props.tsj": "1b92f4a63dacf389edb9fa389a68ebaa",
"assets/assets/images/map/Tiled/Tilesets/Tileset_Ground.tsj": "7bd7212b5612ca22de1a065e16ba6212",
"assets/assets/images/map/Tiled/Tilesets/Tileset_Water.tsj": "6465102c0083a7458be4325abb627395",
"assets/assets/images/map/Tiled/Tilesets/Animation_Flowers_Red.tsj": "23acb38ad10e0685fcd9616e1ac49b3f",
"assets/assets/images/map/Tiled/Tilesets/Animation_Campfire.tsj": "deb94208e9711a3b3c459160e67d6a32",
"assets/assets/images/map/Tiled/Tilesets/Atlas_Props.tsj": "de05a0f4b12d5a7a1311abbc4480c690",
"assets/assets/images/map/Tiled/Tilesets/Objects_Trees.tsj": "b972cf4939af427bb33cc47b78ab4d6a",
"assets/assets/images/map/Tiled/Tilesets/Tileset_RockSlope.tsj": "db0e9968d4f6979fe8045111ba7cd9d3",
"assets/assets/images/map/Tiled/Tilesets/Objects_Buildings.tsj": "6f5e89e71bff39c842d7b334d50bf1ab",
"assets/assets/images/map/Tiled/Tilesets/Tileset_RockSlope_Simple.tsj": "205b96267e75e38d4a088d5b1eb419ed",
"assets/assets/images/map/Tiled/Tilesets/Atlas_Rocks.tsj": "a3773dee297218c952b0f095ca8813b5",
"assets/assets/images/map/round1.tmj": "1dac07a39fdcdfbce0d79eb285ce3792",
"assets/assets/images/map/punyworld_tileset.png": "86f25e027c2712c30d0f6a3049a29564",
"assets/assets/images/map/map3.tmj": "f8bdb3ec9e85648d118782cd30bff51c",
"assets/assets/images/map/Art/Buildings/CityWall_Gate_1.png": "71eee6445e8f719381b847cc79937024",
"assets/assets/images/map/Art/Buildings/House_Hay_Stone_4.png": "a25b82d97552b0749addf33da7f3b489",
"assets/assets/images/map/Art/Buildings/Animations/Door_1.png": "5ee1c929e0e5dabd8736ae5f7e1c455b",
"assets/assets/images/map/Art/Buildings/Animations/Door_1.gif": "1f752ddef65dd880486ec17cbfc5e222",
"assets/assets/images/map/Art/Buildings/House_Hay_Stone_1.png": "f1f6d5bf08c92ceeda37e694b1ce244c",
"assets/assets/images/map/Art/Buildings/House_Hay_Stone_3.png": "6f9702e228ce14123f41e6fadd4031d2",
"assets/assets/images/map/Art/Buildings/Well_Hay_Stone.png": "dafc08482db35ff8a1ba075ce8da3fc0",
"assets/assets/images/map/Art/Buildings/Atlas/Buildings.png": "2863f37c5ae03dcc465fe945a102dcfe",
"assets/assets/images/map/Art/Buildings/House_Hay_Stone_2.png": "947301d9ab28250f6584ba7002affe36",
"assets/assets/images/map/Art/Props/Bulletin_Board.png": "5416a9f1522d177a9838e239196e09c0",
"assets/assets/images/map/Art/Props/Sack.png": "fbd084f6636548ad7fc61ddc12d5f166",
"assets/assets/images/map/Art/Props/Crate_2.png": "57846651da5063186fb6925e859e67ce",
"assets/assets/images/map/Art/Props/Fireplace_1.png": "777210b3e10e5918dbf599428ac019a6",
"assets/assets/images/map/Art/Props/Table_2.png": "2090f84f09afc22b275bd30c1777983a",
"assets/assets/images/map/Art/Props/Animation/Campfire.png": "35e2711c62f7c2e0b65b32d67f7f305f",
"assets/assets/images/map/Art/Props/Animation/Flowers_White.gif": "496729696a0be4c80db28f23339a7d5f",
"assets/assets/images/map/Art/Props/Animation/Flowers_White.png": "164463f6943dce2e7ab82a694db23cf6",
"assets/assets/images/map/Art/Props/Animation/Flowers_Red.png": "9cadef3b9047e06bb46f0cec135a68d5",
"assets/assets/images/map/Art/Props/Animation/Flowers_Red.gif": "39afb2d23dc09f009e4bf40d1af480e1",
"assets/assets/images/map/Art/Props/Banner_1.png": "011121bb7ce03a587f98b52deaad109a",
"assets/assets/images/map/Art/Props/Sign_2.png": "451b638254ce1ec933b89f04b27ec182",
"assets/assets/images/map/Art/Props/Crate_Small_1.png": "45970cafbf7180aa72ff154b7134170f",
"assets/assets/images/map/Art/Props/Lamp_1.png": "ab954b8388293bcff9f6bc9ae9cf7c18",
"assets/assets/images/map/Art/Props/Chopped_Tree_1.png": "2523abb27b20eb3c7060fe2d4485e23f",
"assets/assets/images/map/Art/Props/Plant_Fields_1.png": "63d2b892047425a27e8516c9d14ea3fd",
"assets/assets/images/map/Art/Props/Basket_1.png": "c8cc40e8121a158a721233bdcffaaae9",
"assets/assets/images/map/Art/Props/Barrel_2.png": "f068c897b9f2279a755d01941a1a0f32",
"assets/assets/images/map/Art/Props/Bench_1.png": "57bdb53040bd991fa405467537bb2684",
"assets/assets/images/map/Art/Props/Bench_3.png": "1522136ca784875141575f792cb1d50e",
"assets/assets/images/map/Art/Props/Crate_Water_1.png": "dc2d7bae3d20f595fa184c0d56a553de",
"assets/assets/images/map/Art/Props/Atlas/Props.png": "d0f99eb5691600830b51c4f54f82e486",
"assets/assets/images/map/Art/Props/HayStack_2.png": "24839960f51b2d34504e1e11f21b2eba",
"assets/assets/images/map/Art/Props/Sign_1.png": "ef817aafbf0873d2cf1b5633a0e74aed",
"assets/assets/images/map/Art/Characters/Character/Character_Idle.gif": "815868e820086276f6eea6eb7c1f5d42",
"assets/assets/images/map/Art/Characters/Character/Character_Idle.png": "9a7026909c477789ccbbe55514fff152",
"assets/assets/images/map/Art/Characters/Character/Character_Slash.png": "1739254ddacd48ace3e2e09c4c69a3ff",
"assets/assets/images/map/Art/Characters/Character/Character_Walk.aseprite": "b9527e67eb0433471e10161c45cb6c8b",
"assets/assets/images/map/Art/Characters/Character/Character_Idle.aseprite": "57f254d9ab33640227bcc08daf55074f",
"assets/assets/images/map/Art/Characters/Character/Character_Walk.gif": "d610f2febec8e8bb5bcb0ad72fb9e67b",
"assets/assets/images/map/Art/Characters/Character/Character_Walk.png": "a420c560a0d983df476785653716a883",
"assets/assets/images/map/Art/Characters/Slime/Slime_Idle.png": "e2fa472a8ed66951a2ed589f2c383cdb",
"assets/assets/images/map/Art/Characters/Slime/Slime_Death.aseprite": "fcddbd5956f7b049b853c74c02cd579a",
"assets/assets/images/map/Art/Characters/Slime/Slime_Idle.aseprite": "2bd9f25e48825f54370cc86a91c0ae81",
"assets/assets/images/map/Art/Characters/Slime/Slime_Walk.aseprite": "15c95e036bb9d429a0cc63e5eefdc35f",
"assets/assets/images/map/Art/Characters/Slime/Slime_Attack.aseprite": "fc23f2454a8ffce35710b6850d05bee2",
"assets/assets/images/map/Art/Characters/Slime/Slime_Attack.png": "211c6326410b8826cf1d8c8cb35fe159",
"assets/assets/images/map/Art/Characters/Slime/Slime_Walk.png": "0ef6ac4bef41156020fbd3fd97c599e3",
"assets/assets/images/map/Art/Characters/Slime/Slime_Death.png": "418f4261d8b6e784e72558dfb07c8c11",
"assets/assets/images/map/Art/Rock%2520Slopes/Tileset_RockSlope_Simple.png": "379567ad288a75fb5936a79ba2c56516",
"assets/assets/images/map/Art/Rock%2520Slopes/Tileset_RockSlope.png": "ad6508c5c3349ed6d3a2bea8b036f9de",
"assets/assets/images/map/Art/Tileset_Example.png": "5b7806c5e6395047fc8e726f72853465",
"assets/assets/images/map/Art/Trees%2520and%2520Bushes/Tree_Emerald_4.png": "ce52d7c5b5468b14db56bb8d55911b90",
"assets/assets/images/map/Art/Trees%2520and%2520Bushes/Bush_Emerald_3.png": "b2cdd8cce97ed5b9b16d67a0ee0e7f16",
"assets/assets/images/map/Art/Trees%2520and%2520Bushes/Bush_Emerald_7.png": "a82feac62bac2a36c49a800961e530d1",
"assets/assets/images/map/Art/Trees%2520and%2520Bushes/Bush_Emerald_4.png": "f4e8088b1202c3dbc4c3cea0fc442f64",
"assets/assets/images/map/Art/Trees%2520and%2520Bushes/Tree_Emerald_2.png": "e8c134761caec5f85185f3a9525ea063",
"assets/assets/images/map/Art/Trees%2520and%2520Bushes/Bush_Emerald_2.png": "a42afdc798fc8c9e08bc68e38518464f",
"assets/assets/images/map/Art/Trees%2520and%2520Bushes/Bush_Emerald_1.png": "5f81894aff58d3412152bfed9375c5fc",
"assets/assets/images/map/Art/Trees%2520and%2520Bushes/Bush_Emerald_5.png": "8ed1764beea6f25fac169958bf3bb086",
"assets/assets/images/map/Art/Trees%2520and%2520Bushes/Bush_Emerald_6.png": "bac700418d24a8f5d914f70c7a19f2ac",
"assets/assets/images/map/Art/Trees%2520and%2520Bushes/Tree_Emerald_1.png": "eeb725f79be7ea6fb12d722dae996790",
"assets/assets/images/map/Art/Trees%2520and%2520Bushes/Atlas/Trees_Bushes.png": "724bd353cbd02fca3ff290077f39a657",
"assets/assets/images/map/Art/Trees%2520and%2520Bushes/Tree_Emerald_3.png": "4933dd5c30dd7ff5df100a93ee728825",
"assets/assets/images/map/Art/Water%2520and%2520Sand/Tileset_Water.png": "6140ef4496ca4c2ec00e971b1d499af4",
"assets/assets/images/map/Art/Rocks/Rock_Brown_4.png": "88ab16d564fd5920ffe6c724edf34b95",
"assets/assets/images/map/Art/Rocks/Rock_Brown_2.png": "5552560800d404423cfe1c2e855b2cec",
"assets/assets/images/map/Art/Rocks/Rock_Brown_9.png": "b61946e17627383b3e9055d2849f06de",
"assets/assets/images/map/Art/Rocks/Rock_Brown_6.png": "570e6421396d3f188a3c19860a5a2789",
"assets/assets/images/map/Art/Rocks/Atlas/Rocks.png": "80a9896a97ea0c0bd0008e61f54bffdf",
"assets/assets/images/map/Art/Rocks/Rock_Brown_1.png": "80bad80dd11982aaf00b18c3e7fd7328",
"assets/assets/images/map/Art/Ground%2520Tileset/Tileset_Road.png": "296a083d6076d1817a1a7b4deb5db345",
"assets/assets/images/map/Art/Ground%2520Tileset/Tileset_Ground.png": "67c56cccb5afa41a32c609303ffc18ea",
"assets/assets/images/map/main2.tmj": "3c1478b7937ba26e3ac279548ceb5041",
"assets/assets/images/map/punyworld_tileset.tsj": "9b5681d8938723eb1c5be135ceb83c09",
"assets/assets/images/map/map2.tmj": "718cdda87d94f03c3e40981593c968f5",
"assets/assets/images/map/map.tmj": "ec6580f244d9275140fb1d836d4e3f19",
"assets/assets/images/map/main.tmj": "f64c680d9c436eaf49a276df1530f81d",
"assets/assets/images/arch.png": "45e5bda73c53fcbcfdd70d6dba09c999",
"assets/assets/images/peon.png": "77cdf6c1d1e65df8d78c03d13f78989f",
"assets/assets/images/tower/tower_archer.png": "3e75699592bc49f2192956c60bd52463",
"assets/assets/images/tower/tower_barrack.png": "918f795c48f287df6691f6219d588a29",
"assets/assets/images/tower/tower_dwarf.png": "57a3857c9981f1708e37dda0977a8235",
"assets/assets/images/tower/tower_spirit.png": "b7de33c41cc8f0821567a74a8f3a6e1c",
"assets/assets/images/tower/tower_mage.png": "f2e549ef366c7cc17d2e3c5a66169eec",
"assets/assets/images/projectile.png": "b5018d10f15e60d6b03ff54db778fe43",
"assets/assets/images/effect/explosion.png": "fc1fce1b5e25ff4cc70cb8559a8dc893",
"assets/assets/images/effect/explosion2.png": "c070fa86e1180adb2e61c872552b915c",
"assets/assets/images/knight.png": "c2fb3ee95d56908a32333db53f1f130b",
"assets/assets/images/logo/ai.jpg": "27479fecba4c2e75927841d745d80d94",
"assets/assets/images/logo/bonfire.png": "a0eaa7faa981624e7e557b015912478e",
"assets/assets/images/logo/bonfire.gif": "c759c34432376368945efe24978f08f5",
"assets/assets/audio/sound_bg.mp3": "2cd4d961bbace2116a489a091c8e5943",
"assets/assets/audio/sound_bg2.mp3": "c981cc0898c7af387d9ee3f3f7008804",
"assets/assets/fonts/Catholicon.ttf": "5736ab5d54d2b4037c4c2f0651ed90d5",
"assets/assets/fonts/MedievalSharp-Regular.ttf": "ab74758f51f45a89eb47d5dca0b3580e",
"assets/NOTICES": "e1526e98f1b95d3a66d6e6d9a42cb887",
"assets/AssetManifest.bin": "857fa231ab51da95ae25e266a95cae8d",
"assets/FontManifest.json": "0cf2955f2573ab0fa9100a85e71b1339",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
