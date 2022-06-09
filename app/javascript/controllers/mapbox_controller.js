import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })
    this.#addMarkersToMap()
    // this.#addUserToMap()
    this.#fitMapToMarkers()
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

  #addUserToMap() {
    navigator.geolocation.getCurrentPosition((pos) => {
      this.userLocation = [pos.coords.longitude, pos.coords.latitude]
      new mapboxgl.Marker()
      .setLngLat(this.userLocation)
      .addTo(this.map)
      const bounds = new mapboxgl.LngLatBounds()
      bounds.extend(this.userLocation)
      this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
    })
  }


  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    bounds.extend(this.userLocation)
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }


}
