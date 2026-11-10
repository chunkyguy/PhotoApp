const BASE_URL = "https://picsum.photos";

/*
{
  "id": "0",
  "author": "Alejandro Escamilla",
  "width": 5000,
  "height": 3333,
  "url": "https://unsplash.com/photos/yC-Yzbqy7PY",
  "download_url": "https://picsum.photos/id/0/5000/3333"
}
*/
export async function fetchPhotos({ page = 1, limit = 30 } = {}) {
  const response = await fetch(`${BASE_URL}/v2/list?page=${page}&limit=${limit}`);
  if (!response.ok) throw new Error(`Failed to load photos (${response.status})`);
  return response.json();
}

export async function fetchPhoto(id) {
  const response = await fetch(`${BASE_URL}/id/${id}/info`);
  if (!response.ok) throw new Error(`Failed to load photo ${id} (${response.status})`);
  return response.json();
}

export function photoUrl(id, width, height = width) {
  return `${BASE_URL}/id/${id}/${width}/${height}`;
}
