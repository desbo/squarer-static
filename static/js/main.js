var main = Elm.embed(Elm.Main, document.getElementById('main'), {
  imageUpload: {
    base64: '',
    width: 0,
    height: 0
  }
});

document.getElementById('image').onchange = function readURL(input) {
  if (input.target.files && input.target.files[0]) {
    var reader = new FileReader();

    reader.onload = function(e) {
      var image = new Image();
      var src = e.target.result;

      image.onload = function() {
        main.ports.imageUpload.send({
          base64: src,
          width: image.width,
          height: image.height
        });
      }

      image.src = src;
    }

    reader.readAsDataURL(input.target.files[0]);
  }
};
