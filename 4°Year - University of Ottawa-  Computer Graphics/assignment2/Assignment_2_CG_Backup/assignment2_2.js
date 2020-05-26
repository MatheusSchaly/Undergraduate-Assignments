var objectPosition = new THREE.Vector3( 80, 0, 0 );

function main() {
	
		// Loads the model
	function loadModel() {
		object.traverse( function ( child ) {
			if ( child.isMesh ) { child.material.map = texture; }
		});
		// set position and scale
		object.position.set(objectPosition.x, objectPosition.y, objectPosition.z)
		object.scale.set( 0.3, 0.3, 0.3 ); 
		object.rotation.x = -1.55
		object.rotation.z = 0.9
	
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
	var cameraRig, activeCamera, activeHelper;
	var cameraPerspective, cameraOrtho;
	var cameraPerspectiveHelper, cameraOrthoHelper;
	var frustumSize = 100;

		container = document.createElement( 'div' );
		document.body.appendChild( container );

		scene = new THREE.Scene();

		camera = new THREE.OrthographicCamera( (0.5 * frustumSize * aspect + 20) / - 2, frustumSize * 0.5 * aspect / 2, frustumSize / 2, frustumSize / - 2, 0, 1000 );
		camera.position.z = 60;
		camera.position.x = 0;
		camera.lookAt(objectPosition)
		
		cameraPerspective = new THREE.PerspectiveCamera( 50, 0.5 * aspect, 100, 150 );
		cameraPerspectiveHelper = new THREE.CameraHelper( cameraPerspective );
		scene.add( cameraPerspectiveHelper );
		
		cameraOrtho = new THREE.OrthographicCamera( 0.5 * frustumSize * aspect / - 2, 0.5 * frustumSize * aspect / 2, frustumSize / 2, frustumSize / - 2, 150, 1000 );
		cameraOrthoHelper = new THREE.CameraHelper( cameraOrtho );
		scene.add( cameraOrthoHelper );

		activeCamera = cameraPerspective;
		activeHelper = cameraPerspectiveHelper;

		cameraPerspective.rotation.y = Math.PI;

		cameraRig = new THREE.Group();

		cameraRig.add( cameraPerspective );
		cameraRig.add( cameraOrtho );

		scene.add( cameraRig );
		
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
			var r = Date.now() * 0.0005;
			
			if ( activeCamera === cameraPerspective ) {

				cameraPerspective.fov = 10
				cameraPerspective.far = objectPosition.x - 20;
				cameraPerspective.updateProjectionMatrix();

				cameraPerspectiveHelper.update();
				cameraPerspectiveHelper.visible = true;

				cameraOrthoHelper.visible = false;

			} else {

				cameraPerspective.far = objectPosition.x - 20;
				cameraOrtho.updateProjectionMatrix();

				cameraOrthoHelper.update();
				cameraOrthoHelper.visible = true;

				cameraPerspectiveHelper.visible = false;

			}

			cameraRig.lookAt( objectPosition );

			renderer.clear();

			activeHelper.visible = false;

			renderer.setViewport( 0, 0, SCREEN_WIDTH / 2, SCREEN_HEIGHT );
			renderer.render( scene, activeCamera );

			activeHelper.visible = true;

			renderer.setViewport( SCREEN_WIDTH / 2, 0, SCREEN_WIDTH / 2, SCREEN_HEIGHT );
			renderer.render( scene, camera );

	}

}



window.onload = main;