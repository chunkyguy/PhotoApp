async function getData(url) {
  try {
    const response = await fetch(url);
    if (!response.ok) {
      throw new Error(`Response status: ${response.status}`);
    }
    return await response.json();
  } catch (error) {
    console.error(error.message);
    return null;
  }
}

function randomPage() {
  return Math.floor(Math.random() * 10);
}

export async function getPhotos() {
  return await getData(`https://picsum.photos/v2/list?page=${randomPage()}`);
}

export async function getPhotoById(id) {
  return await getData(`https://picsum.photos/id/${id}/info`);
}
