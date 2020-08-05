var pjtId = document.getElementById('testScript2').getAttribute('pjtId');
var platformId = document.getElementById('testScript2').getAttribute('platformId');

var uploader2 = new plupload.Uploader({
	runtimes : 'html5,flash,silverlight,html4',
	browse_button : 'pickfiles2', // you can pass an id...
	container: document.getElementById('container2'), // ... or DOM Element itself
	url : '/upload/upload2.asp?pjtId='+ pjtId +'&platformId='+ platformId,
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
			document.getElementById('filelist2').innerHTML = '';

			document.getElementById('uploadfiles2').onclick = function() {
				uploader2.start();
				return false;
			};
		},

		FilesAdded: function(up, files) {
			plupload.each(files, function(file) {
				document.getElementById('filelist2').innerHTML += '<div id="' + file.id + '">' + "文件名：" + file.name + ' (' + plupload.formatSize(file.size) + ') <b></b></div>';

			});
		},

		UploadProgress: function(up, file) {
			document.getElementById(file.id).getElementsByTagName('b')[0].innerHTML = ' 上传成功 <span>' + file.percent + "%</span>";
	
		},

		Error: function(up, err) {
			document.getElementById('console2').appendChild(document.createTextNode("\nError #" + err.code + ": " + err.message));
		}
	}
});

uploader2.init();
	