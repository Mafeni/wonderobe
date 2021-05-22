import 'mapbox-gl/dist/mapbox-gl.css';
import mapboxgl from 'mapbox-gl';

const buildMap = (mapElement) => {
  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
  return new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mafeni/ckoziah1p3inu18nrvgoq6tma'
  });
};

const addMarkersToMap = (map, markers) => {
  markers.forEach((marker) => {
    var currentUserColor = "#85A2FF";
    if(marker.currentUser) {
      currentUserColor = "#BA0066";
      console.log(currentUserColor)
    };
    const popup = new mapboxgl.Popup().setHTML(marker.infoWindow)
    new mapboxgl.Marker({
        color:currentUserColor
      })
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
    map.addControl(
      new mapboxgl.GeolocateControl({
      positionOptions: {
      enableHighAccuracy: false
      },
      trackUserLocation: true,
      fitBoundsOptions: {maxZoom:7}
      })
    );
  };
}

export { initMapbox }
