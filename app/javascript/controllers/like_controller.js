import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["count", "link"]

  initialize() {
    this.resource_type = this.data.get("type")
    this.resource_id   = this.data.get("id")
    this.state = this.data.get("state")
    this.count = parseInt(this.countTarget.textContent)
    this.lock  = false
  }

  execute() {
    if (!this.lock) {
      this.lock = true

      if (this.state === "done") {
        this.decrement()
      } else {
        this.increment()
      }
    }
  }

  increment() {
    const csrfToken = document.getElementsByName("csrf-token").item(0).content

    fetch("/like", {
      method: "POST",
      credentials: "same-origin",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken,
      },
      body: JSON.stringify({ "resource_type": this.resource_type, "resource_id": this.resource_id })
    }).then(response => {
      if (response.status == 200) {
        this.refreshByIncrement()
        this.lock = false
      } else {
        let error = new Error(response.statusText)
        error.response = response
        throw error
      }
    }).catch(() => {
      this.lock = false
    })
  }

  decrement() {
    const csrfToken = document.getElementsByName("csrf-token").item(0).content

    fetch("/like", {
      method: "DELETE",
      credentials: "same-origin",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken,
      },
      body: JSON.stringify({ "_method": "_delete", "resource_type": this.resource_type, "resource_id": this.resource_id })
    }).then(response => {
      if (response.status == 200) {
        this.refreshByDecrement()
        this.lock = false
      } else {
        let error = new Error(response.statusText)
        error.response = response
        throw error
      }
    }).catch(() => {
      this.lock = false
    })
  }

  refreshByIncrement() {
    this.count++
    this.countTarget.textContent = this.count
    this.linkTarget.setAttribute("class", "font-weight-bold")
    this.state = "done"
  }

  refreshByDecrement() {
    this.count--
    this.countTarget.textContent = this.count
    this.linkTarget.setAttribute("class", "text-muted")
    this.state = "ready"
  }
}
