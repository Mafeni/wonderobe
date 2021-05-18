import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

const buildMap = (mapElement) => {
  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
  return new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/streets-v10'
  });
};

const addMarkersToMap = (map, markers) => {
  markers.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.infoWindow)
    new mapboxgl.Marker()
      .setLngLat([ marker.lng, marker.lat ])
      .addTo(map)
      .setPopup(popup)
  });
};

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 20, maxZoom: 10 });
};

const initMapbox = () => {
  const mapElement = document.getElementById('map');
  if(mapElement){
    const markers = JSON.parse(mapElement.dataset.markers);
    const map = buildMap(mapElement);
    addMarkersToMap(map, markers);
    fitMapToMarkers(map, markers);
  };
}

export { initMapbox }
