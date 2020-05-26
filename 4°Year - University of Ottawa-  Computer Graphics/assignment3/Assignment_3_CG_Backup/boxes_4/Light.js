// ==========================================================================
// $Id: Light.js,v 1.1 2019/03/08 22:42:42 jlang Exp $
// Light source class for light structure
// ==========================================================================
// (C)opyright:
//
//   Jochen Lang
//   EECS, University of Ottawa
//   800 King Edward Ave.
//   Ottawa, On., K1N 6N5
//   Canada.
//   http://www.eecs.uottawa.ca
//
// Creator: Jochen Lang
// Email:   jlang@uottawa.ca
// ==========================================================================
// $Log: Light.js,v $
// Revision 1.1  2019/03/08 22:42:42  jlang
// First draft of material lab
//
// Revision 1.4  2019/03/07 05:59:03  jlang
// solution
//
// Revision 1.3  2019/03/07 02:50:01  jlang
// Working dat.gui and basic lighting
//
// Revision 1.2  2019/03/05 18:27:02  jlang
// Implementation complete but still to be debugged.
//
// Revision 1.1  2019/03/04 03:31:16  jlang
// Initial draft. No lighting yet.
//
// ==========================================================================

// Constructor ... parameters
function LightSource() {
	this.ambient = glMatrix.vec4.create();
	this.diffuse = glMatrix.vec4.fromValues(1.0,1.0,1.0,1.0);
	this.specular = glMatrix.vec4.fromValues(1.0,1.0,1.0,1.0);
	// attentuation 1/(k_c + k_l r + k_q r^2) 
	// r is the distance of a vertex from the light source
	this.constant_attenuation = 1.0;
	this.linear_attenuation = 0.0;
	this.quadratic_attenuation = 0.0;
	// Finally the light position - directional lights with w = 0.
	this.position = glMatrix.vec4.fromValues(-1.0,1.0,1.0,0.0);
	glMatrix.vec3.normalize(this.position,this.position); 
	this._posLength = 1.0;
}

LightSource.prototype.setLight = function( gl, program, index ) {
    // Make sure the program is current otherwise switch
    let currProgram = gl.getParameter(gl.CURRENT_PROGRAM);
    if ( currProgram != program ) gl.useProgram( program ); 
    let locLight = -1;
	// Build the uniform name including the array
    let varName = 'lights[' + String(index);
    if ((locLight = gl.getUniformLocation(program, (varName + '].ambient')))!=null)
		gl.uniform4fv(locLight, this.ambient);
    if ((locLight = gl.getUniformLocation(program, (varName  + '].diffuse')))!=null)
		gl.uniform4fv(locLight, this.diffuse);
    if ((locLight = gl.getUniformLocation(program, (varName  + '].specular')))!=null)
		gl.uniform4fv(locLight, this.specular);
    if ((locLight = gl.getUniformLocation(program, (varName  + '].constant_attenuation')))!=null)
		gl.uniform1f(locLight, this.constant_attenuation);
    if ((locLight = gl.getUniformLocation(program, (varName  + '].linear_attenuation')))!=null)
		gl.uniform1f(locLight, this.linear_attenuation);
    if ((locLight = gl.getUniformLocation(program, (varName  + '].quadratic_attenuation')))!=null)
		gl.uniform1f(locLight, this.quadratic_attenuation);
	// switch back if needed
    if ( currProgram != program ) gl.useProgram( currProgram );
    return;
}

  
LightSource.prototype.setPosition = function( gl, program, index ) {
    // Make sure the program is current otherwise switch
    let currProgram = gl.getParameter(gl.CURRENT_PROGRAM);
    if ( currProgram != program ) gl.useProgram( program ); 
    // Build the uniform name including the array
    let varName = 'lightPosition[' + String(index);
    let locLight = gl.getUniformLocation(program, (varName  + ']'));
    // let locLight = gl.getUniformLocation(program, 'lightPosition');
    if (locLight != null)
	gl.uniform4fv(locLight, this.position);
    // switch back if needed
    if ( currProgram != program ) gl.useProgram( currProgram );
    return;
}
