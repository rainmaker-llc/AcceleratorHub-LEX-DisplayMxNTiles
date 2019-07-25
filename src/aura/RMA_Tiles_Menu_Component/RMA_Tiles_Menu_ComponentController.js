({
	init : function(component, event, helper) {
        console.log("init");
        var action = component.get('c.Sample');
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                // if response.getReturnValue() size is greater then 0
                if (response.getReturnValue().length > 0){
                    var tileDataList = response.getReturnValue();
                    component.set("v.listOfTiles",tileDataList);
                    console.log("listOfTiles",tileDataList);
                }
            }
            else{
                alert(response.getError()[0].message);
            }
        });
        // enqueue the Action  
        $A.enqueueAction(action);
	},
})