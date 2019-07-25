public class RMA_Tiles_Menu_Controller {
    @AuraEnabled 
    public static List<Tile_Metadata__mdt> Sample() {
       List<Profile> PROFILE = [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1];
        String MyProflieName = PROFILE[0].Name;
        System.debug('query'+[SELECT Label, Profile__c , Link__c, Background_Image__c, Description__c, Image__c, 
                            Type__c, Queary__c FROM Tile_Metadata__mdt where Profile__c =: MyProflieName ORDER BY Label ASC]);
        List<Tile_Metadata__mdt> ListOfTiles = [SELECT Label, Profile__c , Link__c, Background_Image__c, Description__c,
                                                Image__c, Type__c, Queary__c ,Style_For_Count__c,Style_For_Description__c,
                                                Style_For_Label__c
                                                FROM Tile_Metadata__mdt 
                                                where Profile__c =: MyProflieName ORDER BY Label ASC];
        List<Tile_Metadata__mdt> FinalListOfTiles = new List<Tile_Metadata__mdt>();
        for(Tile_Metadata__mdt tiles : ListOfTiles){
            if(tiles.Queary__c != null){
                String Queary = tiles.Queary__c;
                tiles.Queary__c = RMA_Tiles_Menu_Controller.getCount(Queary);
            }
            FinalListOfTiles.add(tiles);
        }
        return FinalListOfTiles;
        
    }
    @AuraEnabled 
    public static String getCount(String Queary){
        system.debug('Database.query(Queary)'+Database.query(Queary));
        try{
            List<SObject> queryResult = Database.query(Queary);
            String returnString;
            for(AggregateResult obj : Database.query(Queary)){
                returnString = String.valueOf(obj.get('expr0'));
            }
            return returnString;
        }catch(QueryException e){
            System.debug(e.getMessage());
            throw new auraHandledException(e.getMessage());
        }
    }
}