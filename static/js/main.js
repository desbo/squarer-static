var main = Elm.embed(Elm.Main, document.getElementById('main'), {
  imageUpload: "None"
});

document.getElementById('image').onchange = function readURL(input) {
  if (input.target.files && input.target.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
      main.ports.imageUpload.send(e.target.result);
    }

    reader.readAsDataURL(input.target.files[0]);
  }
};
