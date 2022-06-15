import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    userLocation: Boolean
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/dk",
      zoom: 16
    })
    this.#addMarkersToMap()
    if (this.userLocationValue) {
      this.#userLatitudeLongitude()
    } else {
      this.#fitMapToMarkers()
    }
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const customMarker = document.createElement("div")
      customMarker.className = "marker"
      customMarker.style.backgroundImage = `url('${marker.image_url}')`
      customMarker.style.backgroundSize = "contain"
      customMarker.style.width = "25px"
      customMarker.style.height = "25px"

      // Pass the element as an argument to the new marker
      new mapboxgl.Marker(customMarker)
        .setLngLat([marker.lng, marker.lat])
        .addTo(this.map)
    });
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    bounds.extend(this.userLocation)
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, minZoom:3, duration: 2000 })
  }

  #userLatitudeLongitude() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition((position) => {
        const userLocation = [position.coords.longitude, position.coords.latitude]
        new mapboxgl.Marker()
        .setLngLat(userLocation)
        .addTo(this.map)
        const bounds = new mapboxgl.LngLatBounds()
        bounds.extend(userLocation)
        this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
      });
    }
  }
}


// mapbox://styles/mapbox/streets-v11
