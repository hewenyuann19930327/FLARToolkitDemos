[Embed(source="/pattern1.pat", mimeType="application/octet-stream")]
private  var   Pattern:Class;
[Embed(source="/pattern2.pat", mimeType="application/octet-stream")]
private  var   Pattern2:Class;
 
fpattern = new FLARCode(16, 16);
fpattern.loadARPatt(new Pattern());
 
fpattern2 = new FLARCode(16, 16);
fpattern2.loadARPat(new Pattern2());
 
patternArray = [fpattern, fpattern2];
 
patternSizeArray = [80, 80];
 
detector = new FLARMultipleMarkerDetector(cameraParams, patternArray, patternSizeArray)

private function loop(e:Event):void{
 
            try{
 
                bmd.draw(vid);
 
                var numDetectedMarkers:int = detector.detectMarkerLite(raster, 80);
                var markerId:int;
                for(var i:int = 0; i < numDetectedMarkers; i++){
 
                    //only use markers with a confidence rating of .5+
                    if(detector.getConfidence(i) > 0.4){
                        //figure out which marker we're looking at
                        markerId = detector.getARCodeIndex(i);
                        detector.getTransmationMatrix(i, transMats[markerId]);
                    }
 
                }
 
                //apply the transform matricies to the basenodes
                for(var j:Number = 0; j < baseNodes.length; j++){
                    baseNodes[j].setTransformMatrix(transMats[j]);
                    r.renderScene(s, c, v);
                    trace('set trans mat for ...', baseNodes[j]);
                }
 
            }
            catch(e:Error){}
} 
