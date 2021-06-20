window.addEventListener('load', function() {
  var datepickers = document.querySelectorAll('.db-datepicker');
  var i;

  for (i = 0; i < datepickers.length; i++) {
    var datepicker = new Datepicker(datepickers[i], {
      format: 'mm-dd-yyyy'
    });
  }
})
