import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("hello");
    mapboxgl.accessToken = 'pk.eyJ1IjoiY2hhY2hpbGxzIiwiYSI6ImNsZmt6ZGtmMDAwNXUzeW8zYWs1ZTR6ejAifQ.lgzKRSs2gyIavtaSX7kbwQ'
    const map = new mapboxgl.Map ({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v11',
      center: [2.209667, 46.232193],
      zoom: 5
    });

    const geocoder = new MapboxGeocoder({
      accessToken: mapboxgl.accessToken,
      mapboxgl: mapboxgl
    });

    document.getElementById('geocoder').appendChild(geocoder.onAdd(map));
    geocoder.on('result', function(e) {
      document.getElementById('tool_location').value = e.result.place_name

      console.log(e.result)
    })

  }
}
