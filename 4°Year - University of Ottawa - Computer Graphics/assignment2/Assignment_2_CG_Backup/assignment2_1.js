var helperAt = new THREE.Vector3( 0, 0, 0 );
var cameraAt = new THREE.Vector3( -4, 0, 0 );

function main() {
	
		// Loads the model
	function loadModel() {
		object.traverse( function ( child ) {
			if ( child.isMesh ) { child.material.map = texture; }
		});
		// set position and scale
		object.position.set(helperAt.x, helperAt.y, helperAt.z)
		object.scale.set( 0.10, 0.10, 0.10);
	
		scene.add( object );
	}

	var manager = new THREE.LoadingManager( loadModel );
	manager.onProgress = function ( item, loaded, total ) {
		console.log( item, loaded, total );
	};

	var textureLoader = new THREE.TextureLoader( manager );
	var texture = textureLoader.load( 'models/tiger.jpg' );

    function onProgress( xhr ) {
		if ( xhr.lengthComputable ) {
			var percentComplete = xhr.loaded / xhr.total * 100;
			console.log( 'model ' + Math.round( percentComplete, 2 ) + '% downloaded' );
		}
	}

	function onError() {}

	var loader = new THREE.OBJLoader( manager );
	loader.load( 'models/tiger.obj', function ( obj ) {object = obj;}, onProgress, onError );
	
	//
		
	var SCREEN_WIDTH = window.innerWidth;
	var SCREEN_HEIGHT = window.innerHeight;
	var aspect = SCREEN_WIDTH / SCREEN_HEIGHT;

	var container, stats;
	var camera, scene, renderer;
	var cameraRig, activeCamera;
	var cameraOrtho;
	var cameraOrthoHelper;

		container = document.createElement( 'div' );
		document.body.appendChild( container );

		scene = new THREE.Scene();

		camera = new THREE.OrthographicCamera( 10 * aspect / - 2, 10 * aspect / 2, 5 / 2, 5 / - 2, 0, 2000 );
		camera.position.y = -100;
		camera.position.x = -100;
		camera.position.z = 900;
		
		cameraOrtho = new THREE.OrthographicCamera( 10 * aspect / - 2, 10 * aspect / 2, 5 / 2, 5 / - 2, 0, 10 );
		cameraOrthoHelper = new THREE.CameraHelper( cameraOrtho );
		cameraOrtho.position.y = 0;
		cameraOrtho.position.x = -8;
		cameraOrtho.position.z = 0;
		
		
		scene.add( cameraOrthoHelper );
		
		//
		
		// add a lightsource - at the camera
		let pointLight = new THREE.PointLight(0xeeeeee);
		camera.add(pointLight);

		// add a bit of ambient light to make things brighter
		let ambientLight = new THREE.AmbientLight(0x909090)
		scene.add(ambientLight)

		//

		renderer = new THREE.WebGLRenderer( { antialias: true } );
		renderer.setPixelRatio( window.devicePixelRatio );
		renderer.setSize( SCREEN_WIDTH, SCREEN_HEIGHT );
		container.appendChild( renderer.domElement );

		renderer.autoClear = false;
		
		render();

		function render() {
		
			requestAnimationFrame( render );
			
			cameraOrtho.updateProjectionMatrix();

			cameraOrthoHelper.update();
			cameraOrthoHelper.visible = true;

			camera.lookAt( cameraAt );
			cameraOrtho.lookAt( helperAt );

			renderer.clear();

			renderer.setViewport( 0, 0, SCREEN_WIDTH / 2, SCREEN_HEIGHT );
			renderer.render( scene, cameraOrtho );

			renderer.setViewport( SCREEN_WIDTH / 2, 0, SCREEN_WIDTH / 2, SCREEN_HEIGHT );
			renderer.render( scene, camera );

	}

}

window.onload = main;