import { Link } from "react-router-dom";
import "./PhotoTile.css";

/*
{
    "albumId": 1,
    "id": 1,
    "title": "accusamus beatae ad facilis cum similique qui sunt",
    "url": "https://via.placeholder.com/600/92c952",
    "thumbnailUrl": "https://via.placeholder.com/150/92c952"
  }
*/
export function PhotoTile({ title, url, path }) {
  return (
    <li className="photoTile">
      <Link to={path}>
        <img src={url} alt={title} />
      </Link>
    </li>
  );
}
