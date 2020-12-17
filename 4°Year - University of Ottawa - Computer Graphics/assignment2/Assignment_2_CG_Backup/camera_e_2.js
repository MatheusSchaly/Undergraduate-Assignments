var scene = new THREE.Scene();
var object;

function main() {
	
	// Loads the model
	function loadModel() {
		object.traverse( function ( child ) {
			if ( child.isMesh ) { child.material.map = texture; }
		});

		// Scale object to size 2 and center it		
		const box = new THREE.Box3().setFromObject(object);
		const boxSize = box.getSize(new THREE.Vector3());
		// Find maximum dimension
		const boxSizeln = Math.max( boxSize.x, boxSize.y, boxSize.z );
		// Find box center	
		const boxCenter = box.getCenter(new THREE.Vector3());
		// set position and scale
		object.position.set( -2.0*boxCenter.x/boxSizeln, 
							 -2.0*boxCenter.y/boxSizeln, 
							 -2.0*boxCenter.z/boxSizeln );
		object.scale.set( 2.0/boxSizeln, 2.0/boxSizeln, 2.0/boxSizeln ); 
	
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
	
	init()	
}

function init() {
	if (THREE.WEBGL.isWebGLAvailable() === false) {
		document.body.appendChild(THREE.WEBGL.getWebGLErrorMessage());
	}
	var container = document.createElement('div');
	document.body.appendChild(container);
	renderer = new THREE.WebGLRenderer();
	renderer.setClearColor(new THREE.Color(0x333333));
	renderer.setSize(window.innerWidth, window.innerHeight);
	container.appendChild(renderer.domElement);
	
	var aspectRatio = window.innerWidth / window.innerHeight;
	var eye_1 = new THREE.Vector3( 0.0, -5.0, 5.0 );
	var at_1 = new THREE.Vector3( 0.0, 0.0, 0.0);
	var up_1 = new THREE.Vector3( 0.0, 1.0, 0.0);
	var eye_2 = new THREE.Vector3( 0.0, -5.0, 5.0 );
	var at_2 = new THREE.Vector3( 0.0, 0.0, 0.0);
	var up_2 = new THREE.Vector3( 0.0, 1.0, 0.0);
	var d_width = 2.0;
	var d_height = 2.0;
	var d_near = 4.0;
	var d_far = 50.0;
	
	camera_1 = new THREE.OrthographicCamera(-d_width/2.0 * aspectRatio, d_width/2.0 *aspectRatio, d_height/2.0, -d_height/2.0, d_near, d_far);
	camera_1.position.copy(eye_1);
	camera_2 = new THREE.OrthographicCamera(-d_width/2.0 * aspectRatio, d_width/2.0 *aspectRatio, d_height/2.0, -d_height/2.0, d_near, d_far);
	camera_2.position.copy(eye_2);
	
	// add a lightsource - at the camera_1
	let pointLight = new THREE.PointLight(0xeeeeee);
	camera_1.add(pointLight);
	// add a bit of ambient light to make things brighter
	let ambientLight = new THREE.AmbientLight(0x909090)
	scene.add(ambientLight)

	render();
	
	function render() {
		requestAnimationFrame(render);
		updateLookAt();
		renderer.render(scene, camera_1);
		renderer.render(scene, camera_2);
	}
	
	function updateLookAt() {
		camera_1.position.copy(eye_1);
		camera_1.up.copy(up_1);
		camera_1.lookAt(at_1);
		camera_1.updateMatrix();
		camera_2.position.copy(eye_2);
		camera_2.up.copy(up_2);
		camera_2.lookAt(at_2);
		camera_2.updateMatrix();
	}
	
}
	
window.onload = main;

	
	