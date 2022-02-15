import { Controller } from "stimulus";
import mql from "@microlink/mql";

export default class extends Controller {
  static targets = ["input", "imageInput", "output", "button"];

  connect() {
    this.previewImage = this.outputTarget.querySelector("img");
  }

  async handleChange() {
    const { status, data } = await mql(this.inputTarget.value);
    if (status == "success") {
      this.setFormData(data);
      this.renderPreview(data);
      this.buttonTarget.disabled = false;
    }
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
