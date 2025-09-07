const photos = [
  {
    id: "37",
    author: "Austin Neill",
    width: 2000,
    height: 1333,
    url: "https://unsplash.com/photos/erTjj730fMk",
    download_url: "https://picsum.photos/id/37/2000/1333",
  },
  {
    id: "38",
    author: "Allyson Souza",
    width: 1280,
    height: 960,
    url: "https://unsplash.com/photos/JabLtzJl8bc",
    download_url: "https://picsum.photos/id/38/1280/960",
  },
  {
    id: "39",
    author: "Luke Chesser",
    width: 3456,
    height: 2304,
    url: "https://unsplash.com/photos/pFqrYbhIAXs",
    download_url: "https://picsum.photos/id/39/3456/2304",
  },
  {
    id: "40",
    author: "Ryan Mcguire",
    width: 4106,
    height: 2806,
    url: "https://unsplash.com/photos/N-1XGL54pQg",
    download_url: "https://picsum.photos/id/40/4106/2806",
  },
  {
    id: "41",
    author: "Nithya Ramanujam",
    width: 1280,
    height: 805,
    url: "https://unsplash.com/photos/fTKetYpEKNQ",
    download_url: "https://picsum.photos/id/41/1280/805",
  },
  {
    id: "42",
    author: "Luke Chesser",
    width: 3456,
    height: 2304,
    url: "https://unsplash.com/photos/KR2mdHJ5qMg",
    download_url: "https://picsum.photos/id/42/3456/2304",
  },
  {
    id: "43",
    author: "Oleg Chursin",
    width: 1280,
    height: 831,
    url: "https://unsplash.com/photos/IoCWq07GaG4",
    download_url: "https://picsum.photos/id/43/1280/831",
  },
];

export function getPhotos() {
  return photos;
}

export function getPhotoById(id) {
  return photos.find((it) => it.id === id) || undefined;
}
