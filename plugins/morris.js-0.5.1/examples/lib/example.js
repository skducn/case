$(function () {

  // Use Morris.Bar
Morris.Bar({
  element: 'graph',
  data: [
    {x: 'iOS', y: 0},
    {x: 'android', y: 0},
    {x: 'server', y: 0},
    {x: 'php', y: 44}
  ],
  xkey: 'x',
  ykeys: ['y'],
  labels: ['ÊýÁ¿'],
  barColors: function (row, series, type) {
    if (type === 'bar') {
      var red = Math.ceil(255 * row.y / this.ymax);
      return 'rgb(' + red + ',0,0)';
    }
    else {
      return '#000';
    }
  }
});
});