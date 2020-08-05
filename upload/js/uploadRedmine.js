var pjtId = document.getElementById('testScript').getAttribute('pjtId');
var platformId = document.getElementById('testScript').getAttribute('platformId');

var uploader1 = new plupload.Uploader({
	runtimes : 'html5,flash,silverlight,html4',
	browse_button : 'pickfiles1', // you can pass an id...
	container: document.getElementById('container1'), // ... or DOM Element itself
	url : '/upload/upload.asp?pjtId='+ pjtId +'&platformId='+ platformId,
	flash_swf_url : 'upload/js/Moxie.swf',
	silverlight_xap_url : 'upload/js/Moxie.xap',
	filters : {
		max_file_size : '10mb',
		mime_types: [
			{title : "Image files", extensions : "jpg,gif,png,txt,exe,mp4"},
			{title : "Zip files", extensions : "zip"}
		]
	},
	init: {
		PostInit: function() {
			document.getElementById('filelist1').innerHTML = '';

			document.getElementById('uploadfiles1').onclick = function() {
				uploader1.start();
				return false;
			};
		},

		FilesAdded: function(up, files) {
			plupload.each(files, function(file) {
				document.getElementById('filelist1').innerHTML += '<div id="' + file.id + '">' + "文件名：" + file.name + ' (' + plupload.formatSize(file.size) + ') <b></b></div>';

			});
		},

		UploadProgress: function(up, file) {
			document.getElementById(file.id).getElementsByTagName('b')[0].innerHTML = ' 上传成功 <span>' + file.percent + "%</span>";
	
		},

		Error: function(up, err) {
			document.getElementById('console1').appendChild(document.createTextNode("\nError #" + err.code + ": " + err.message));
		}
	}
});

uploader1.init();
	