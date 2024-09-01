import { useEffect, useState } from "react";
import { Loading } from "../components/Loading";
import { PhotoTile } from "../components/PhotoTile";
import "./Home.css";

export function Home() {
  const [photoList, setPhotoList] = useState([]);

  async function fetchData() {
    const response = await fetch("https://jsonplaceholder.typicode.com/photos");
    const content = await response.json();
    setPhotoList(content);
  }

  useEffect(() => {
    fetchData();
  }, []);

  return (
    <>
      {photoList.length === 0 ? (
        <Loading />
      ) : (
        <ul className="photoList">
          {photoList.map(({ id, title, thumbnailUrl }) => (
            <PhotoTile
              key={id}
              title={title}
              url={thumbnailUrl}
              path={`/details/${id}`}
            />
          ))}
        </ul>
      )}
    </>
  );
}
