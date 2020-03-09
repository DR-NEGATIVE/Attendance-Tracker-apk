import 'package:flutter/material.dart';
void main(){
  runApp( 
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Attendace Calculator",
      home : SIform(),
      theme: ThemeData
      (
        brightness: Brightness.dark,
        primaryColor : Colors.indigo,
        accentColor : Colors.indigoAccent

      ),


    )
  );

}
class SIform extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
  
}
 class _SIFormState extends State<SIform>{
   var _formKey =GlobalKey<FormState>();
   var _Choice=['Percentage','Numbers'];
   final double _minimumPadding = 5.0;
   var _currentItemSelected ='Percentage';
   @override
   void intitState(){
     super.initState();
     _currentItemSelected=_Choice[0];
    
   }
   TextEditingController principalController =TextEditingController();
   TextEditingController roiController =TextEditingController();
   TextEditingController termController =TextEditingController();
   var main_call="";
   var tester="";

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle =Theme.of(context).textTheme.title;
    return Scaffold(
     // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
      title: Text('Attendance Calculator '),
      ),
      body:Form(
        key: _formKey,
        child :Padding(
          padding: EdgeInsets.all(_minimumPadding *2),
        child: ListView(children: <Widget>[
          getImageAsset(),
          Padding(
            padding: EdgeInsets.only(top:_minimumPadding,bottom: _minimumPadding ),
            child: TextFormField(
            keyboardType: TextInputType.number,
            controller: principalController ,
            validator: (String value){
              if (value.isEmpty){
                return "Please Enter Total lecture ";
              }
            },
            decoration: InputDecoration(
              labelText: 'Total Lecture',//priciplae main
              hintText: 'Enter The No Of Lecture Held',
              border: OutlineInputBorder(
                borderRadius : BorderRadius.circular(5.0)
              )
              ),
              
          )),
           Padding(
            padding:  EdgeInsets.only(top:_minimumPadding,bottom: _minimumPadding),
            child: TextFormField(
            keyboardType: TextInputType.number,
            controller: roiController,
            validator: (String value){
              if(value.isEmpty){
                return "Enter Minimum criteria Required";
              }
            },
            decoration: InputDecoration(
              labelText: 'Required',
              hintText: 'Minimun creteria eg 75 60 70',
              border: OutlineInputBorder(
                borderRadius : BorderRadius.circular(5.0)
              )
              ),
              
          )),
         Padding(padding:EdgeInsets.only(top: _minimumPadding,bottom: _minimumPadding),
         child : Row(
            children: <Widget>[
            Expanded(child:  TextFormField(
            keyboardType: TextInputType.number,
            controller: termController,
            validator: (String value){
              if(value.isEmpty){
                return "Please Provide current taken Lecture or Attendance";
              }
            },
            decoration: InputDecoration(
              labelText: 'Current Attendance',//principale
              hintText: 'Enter The No Of Lecture Attended',
              border: OutlineInputBorder(
                borderRadius : BorderRadius.circular(5.0)
              )
              ),
              
          )),
          Container(width: _minimumPadding*5,),
         Expanded(child: DropdownButton<String>(items:_Choice.map((String value){
              return DropdownMenuItem<String>(
                value: value,
                child :Text(value),
                
              );
          }).toList(),
          value: _currentItemSelected, onChanged: (String newValueSelected) {
            tester=newValueSelected;
            onDropDownItemSelected(newValueSelected);

          },
         ))]
            ))
        , Padding(
           padding: EdgeInsets.only(bottom: _minimumPadding ,top :_minimumPadding),
           child: Row(children: <Widget>[
            Expanded(child: RaisedButton(
               color: Theme.of(context).accentColor,
               textColor: Theme.of(context).primaryColorDark,
               child: Text('Calculate',textScaleFactor :1.5,), onPressed: () {
                 setState(() {
                   if(_formKey.currentState.validate()){
                  this.main_call=calulateatt();}
                 });
            },),),
            Container(width: _minimumPadding*5,)//pddding
           , Expanded(
             child: RaisedButton(
               color: Theme.of(context).primaryColorDark,
               textColor: Theme.of(context).primaryColorLight,
             child: Text('Reset',textScaleFactor :1.5,), onPressed: () {
               setState(() {
                 reset();
               });
              
            },),
            
            ) ],
          )
           ),
           Padding(padding:EdgeInsets.all(_minimumPadding*2),
           child : Text(this.main_call,style: textStyle,))
           ],) )),
      );
  }
     Widget getImageAsset() {
      AssetImage assetImage =AssetImage('images/FAVPNG_time-attendance-clocks-time-tracking-software-management-project_eYC3ApTs.png');
      Image image = Image (image: assetImage,width:200.0,height: 200.0);
      return Container(child: image,margin: EdgeInsets.all(_minimumPadding*10),); }
      void onDropDownItemSelected(String newValueSelected){
        setState(() {
          this._currentItemSelected=newValueSelected;
        });
      }
      String  calulateatt(){
        double all_lec=double.parse(principalController.text);
         double required=double.parse(roiController.text);
        
          double avail=double.parse(termController.text);
          if(identical(tester,"Numbers")){
             if(required<((avail*100)/all_lec)){
             required=required/100;
            double hc=avail-(all_lec*required);
            double ans_m=hc/required;
            int ans=ans_m.round();
            return "You can leave $ans lectures :)";

          }
          else if(required==((avail*100)/all_lec)){
            return "All Safe :-)";
          }
          else{
             required=required/100;
          double x=(1-(required));
          double fina = (required*all_lec)-avail;
          double an = fina/x;
        int ans= an.round();
          return "You required $ans  more lecture to Back on track :|";}
          }
          else{
          if(required<avail){
             required=required/100;
             avail=(avail*all_lec)/100;
            double hc=avail-(all_lec*required);
            double ans_m=hc/required;
            int ans=ans_m.round();
            return "You can leave $ans lectures :)";

          }
          else if(required==avail){
            return "All Safe :-)";
          }
          else{
             required=required/100;
          avail=(avail*all_lec)/100;
          double x=(1-(required));
          double fina = (required*all_lec)-avail;
          double an = fina/x;
        int ans= an.round();
          return "You required $ans  more lecture to Back on track :|";}
          }



      }
      void reset(){
        principalController.text="";
        roiController.text="";
        termController.text="";
        main_call="";
        _currentItemSelected =_Choice[0];

      }
  }