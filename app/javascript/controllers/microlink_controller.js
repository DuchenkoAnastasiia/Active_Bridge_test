import { Controller } from "stimulus";
import mql from "@microlink/mql";

export default class extends Controller {
  static targets = ["input", "imageInput", "output", "button", "message"];

  connect() {
    this.previewImage = this.outputTarget.querySelector("img");
  }

  async handleChange() {
    this.messageTarget.innerText = null;
    this.clearFormData();
    this.clearPreview();
    if (this.inputTarget.value != "") {
      try {
        this.messageTarget.innerText = "Loading preview...";
        const { status, data } = await mql(this.inputTarget.value);
        if (status == "success") {
          this.setFormData(data);
          this.renderPreview(data);
          this.messageTarget.innerText = null;
          this.buttonTarget.disabled = false;
        } else {
          this.messageTarget.innerText =
            "There was an error fetching the link preview.";
        }
      } catch (e) {
        this.messageTarget.innerText =
          "There was an error fetching the link preview.";
      }
    }
  }
  clearFormData() {
    this.imageInputTarget.value = null;
  }
  clearPreview() {
    this.previewImage.setAttribute("src", "");
    this.outputTarget.style.display = "none";
  }
  renderPreview(data) {
    data?.image?.url
      ? this.previewImage.setAttribute("src", data.image.url)
      : null;
    this.outputTarget.style.display = "block";
  }

  setFormData(data) {
    this.imageInputTarget.value = data?.image?.url ? data?.image?.url : null;
  }
}
