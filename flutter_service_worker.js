'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "b4d3a91af621a7862edd8209f882dfcf",
"assets/AssetManifest.bin.json": "fb33cf9ef40c232140ab1a6820e0b139",
"assets/AssetManifest.json": "98aea2abe51912458dbd37a38c79979b",
"assets/assets/authors/acb.jpg": "41387955cbcba1788afbe950622e7a32",
"assets/assets/authors/buddhisagar.jpg": "9addc76f98db442216274a7749231c06",
"assets/assets/authors/colleen.jpg": "8476cd55d5557be0e8c3b3c95eaa8f01",
"assets/assets/authors/fyodor.jpg": "baf45e72862018213ec199f1df6be1f5",
"assets/assets/authors/greene.jpg": "273a3f037b075a0c39ee2c236d90b3a8",
"assets/assets/authors/haruki.jpg": "62ab7f54ed683973a68a5e85b05a197f",
"assets/assets/authors/morgan.jpg": "5f02148cdc1cb64520a30ba8256a288f",
"assets/assets/authors/napoleon.jpg": "0357682511dcd4f6d8adaae8f76c59d5",
"assets/assets/authors/sage.jpg": "6a9f65c9709814e17802d16d08f9c90b",
"assets/assets/bookImages/bestsellerpage/48lawsofpower.webp": "0d9f36c2088ff3e2fab2c7cd2692b01f",
"assets/assets/bookImages/bestsellerpage/biglittle.jpg": "cb7e25ddc9bf58fb92f2714773adea52",
"assets/assets/bookImages/bestsellerpage/howtotalktoanyone.webp": "9c44ce503bdf55d4d3f725956ad9c324",
"assets/assets/bookImages/bestsellerpage/ijoriya.webp": "5c57a85a3957dc6a1247d805388ad5b2",
"assets/assets/bookImages/bestsellerpage/ikigai.webp": "acd7426604c0aa4b45d1b2c6f3a272a9",
"assets/assets/bookImages/bestsellerpage/itstartswithus.webp": "dac9f7199257b7763b8b8472a23496fe",
"assets/assets/bookImages/bestsellerpage/jeevankadakifool.webp": "33272e05c5754edc78c9959ac304fd3b",
"assets/assets/bookImages/bestsellerpage/jujutsu.jpg": "ecb7a8a575eda6d482fb0328af1bafe9",
"assets/assets/bookImages/bestsellerpage/karnalib.webp": "9ea9ca43950a82536835478c371bcd59",
"assets/assets/bookImages/bestsellerpage/Lotr.jpg": "338c717c7418b189681ffe51327669b5",
"assets/assets/bookImages/bestsellerpage/thehiddenhindu.webp": "398ae228cc1862a1181c0fa8f3f266ae",
"assets/assets/bookImages/bestsellerpage/thelovehypothesis.webp": "c817df9ee8ca4d7278da7b7178c94b00",
"assets/assets/bookImages/bestsellerpage/thinkandgrowrich.webp": "6f273ce999daa3af382fe7bdafe929c8",
"assets/assets/bookImages/cinematic/dune.webp": "792b73fd78b99b703e5558e3b77356ee",
"assets/assets/bookImages/cinematic/hungergame.webp": "b3725613addc112cb2d36d572b0d37e2",
"assets/assets/bookImages/Demon_Slayer.jpg": "86d932824825d25b90c715cf24d655dd",
"assets/assets/bookImages/got.jpg": "c66c56e9f38f5f9f26f677371410ef73",
"assets/assets/bookImages/harrypotter.jpg": "141f9cdfe776e8e6a70969417651867f",
"assets/assets/bookImages/newarrival/agoodgirlsguidetomurder.webp": "3933293b37b1c8e5e93e7e5c6f8c86e4",
"assets/assets/bookImages/newarrival/betterthanmovies.webp": "59f51d8ac21248e342a63a36bee77f47",
"assets/assets/bookImages/newarrival/bhagavadgita.webp": "41faefbf878058d5af0e91bac271c045",
"assets/assets/bookImages/newarrival/bitterblue.webp": "91f13be637ec478d84c2b085944dd79b",
"assets/assets/bookImages/newarrival/horridthehenry.webp": "6e2ebb329bbd88e96e7cf2747baf486d",
"assets/assets/bookImages/newarrival/idontloveyouanymore.webp": "693139979000694dc0b3893ce441b92f",
"assets/assets/bookImages/newarrival/itendwithus.webp": "fbcbd6b33f272426a5230f2e22339237",
"assets/assets/bookImages/newarrival/murakami.webp": "ba9d6a4763d060c628c2d90e87568f85",
"assets/assets/bookImages/newarrival/savagelover.webp": "cede9d1789ce5a6a70d6ec3938ee930c",
"assets/assets/bookImages/newarrival/setodharti.webp": "ef2882dd6fe8d53c684cd60e7233c210",
"assets/assets/bookImages/newarrival/thecouragetobedisliked.webp": "707612c434e5cf7a0be57d93438965cd",
"assets/assets/bookImages/newarrival/thegodofsmallthings.webp": "c4e0a828b1fff1231d6117a66da09bc6",
"assets/assets/bookImages/newarrival/thepowerofyoursubconsciousmind.webp": "3466b68faec5edd430c38618212e09c6",
"assets/assets/bookImages/newarrival/thepsychologyofmoney.webp": "815649f7f7d6f416afd41f94255be040",
"assets/assets/bookImages/newarrival/uslediyekoumer.webp": "3553e92d4afe0b9bdb3249bb9b3fd320",
"assets/assets/bookImages/newarrival/womancode.webp": "8e3f14e239eff20e9572fa519a7deb4f",
"assets/assets/bookImages/the_witcher.jpg": "ccaca8c7eb6acf968ed9359dfe744b12",
"assets/assets/images/apple.png": "4709b56beda03ad118d39bd40d5f75bf",
"assets/assets/images/bestseller.jpg": "3cd616ba70866451f7469c09d17ab6d1",
"assets/assets/images/bestseller1.jpg": "8a4a827e68fee0326dc7056c86ec8580",
"assets/assets/images/book.jpg": "41d0506285193a43b686c42099c39be2",
"assets/assets/images/children.jpg": "2f01d0ca9a86b1ca8ed9a4930c85e0dd",
"assets/assets/images/cinematic.jpg": "e9471d705be87308dc207231268ddf6c",
"assets/assets/images/esewa.webp": "5b823c105e746c9ff6bd4771fe8a89c1",
"assets/assets/images/google.png": "d40c12a7a090c608e1cb5ff5d992aae1",
"assets/assets/images/khalti.png": "9d544a031224d942b88f7a93b6d97329",
"assets/assets/images/latest.jpg": "96314fdc811c0669e99b90f51276ea8c",
"assets/assets/images/Logo1.jpg": "834995d5da154decf8b66b6a16829f22",
"assets/assets/images/manga.jpg": "97a260f24ed15a71e0544695afdb18bb",
"assets/assets/images/paypal.png": "670b15e6a4aa68089c2d2339ca07f560",
"assets/assets/images/tarrot.jpg": "5318049bab9349260aee334303ce41e6",
"assets/assets/images/used.jpg": "119b232ceba1b68a8f4bc20ed8f4c381",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "db5db0d37b821e7e5b24c04e82f695b0",
"assets/NOTICES": "2b1cf96fd81fc785e9967e82b6c22c26",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/khalti_flutter/assets/dialog/error.svg": "04bdc43ab1451975f939f0b40289c5fb",
"assets/packages/khalti_flutter/assets/dialog/info.svg": "c10fa621ec57b2cec6e0b15d35f0ba69",
"assets/packages/khalti_flutter/assets/dialog/success.svg": "49566d38a0c225e95241c025b87d962c",
"assets/packages/khalti_flutter/assets/error/general-error.svg": "e64aa723b6f78b8aeff9eeb7f6785f52",
"assets/packages/khalti_flutter/assets/error/no-internet.svg": "770e67f4e2118e6404d573b7be8e3cca",
"assets/packages/khalti_flutter/assets/logo/connect-ips.svg": "ea35ce77ea086b55778f3f5356658201",
"assets/packages/khalti_flutter/assets/logo/khalti-inner-icon.svg": "1f349f9fd4f4b2f2c4df8afdd7f7c71e",
"assets/packages/khalti_flutter/assets/logo/khalti.svg": "ca48562ef24de3a8e31901de5845aaa8",
"assets/packages/khalti_flutter/assets/logo/sct.svg": "8b032a098e9073d75e8bda7079492cba",
"assets/packages/khalti_flutter/assets/payment/connect-ips.svg": "d6dec4787c7233dc7f5862f588355dfd",
"assets/packages/khalti_flutter/assets/payment/ebanking.svg": "f3194c2c543b2dc3211ad66d7b38776f",
"assets/packages/khalti_flutter/assets/payment/mobilebanking.svg": "d330bd6fa7f5c1445121042b85a86b50",
"assets/packages/khalti_flutter/assets/payment/sct.svg": "391f0a569f6021ba08b2bace6067538d",
"assets/packages/khalti_flutter/assets/payment/wallet.svg": "334172609f45671f3a6fc8494f5359de",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"flutter_bootstrap.js": "fd9e298a6a57ea771dfdd4f2f70761b4",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "c2194555de9ddab26b32c5d9a87ab83b",
"/": "c2194555de9ddab26b32c5d9a87ab83b",
"main.dart.js": "70f8e7375cee792c7b01ae1002a129f6",
"manifest.json": "7806e7e9264cf89ae95bf9fa7bc80a7f",
"version.json": "a11f40ba374ea6f5d908b149b3d6104d"};
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
