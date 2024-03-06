import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../provider/cat_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    @override
    void initState() {
      final provider = Provider.of<CatsProvider>(context,listen: false);
      super.initState();
      provider.getCatsData();
    }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CatsProvider>(context);
    var cats_list = provider.cats;
    TextEditingController textcontroller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider x Api'),
        centerTitle: true,
      ),
      body: 
      provider.Loading == true ? 
      const Center(
        child: SpinKitPouringHourGlass(
          color: Colors.blueGrey,
          size: 50.0,
        ),
       )
       : Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            AnimSearchBar(width: 400, textController: textcontroller, onSuffixTap: (){
              setState(() {
                textcontroller.clear();
              });
            }, onSubmitted: (textcontroller) { 
              provider.SearchData(textcontroller);
             }, 
            ),
            Expanded(
              child: Consumer(builder: (context, CatsProvider catss, child) =>
                 ListView.builder(
                  itemCount: catss.serchedpets.length,
                  itemBuilder: (context,index){
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(catss.serchedpets[index].image.toString()) ,
                              ),
                            ),
                            const SizedBox(height: 15,),
                            Text(catss.serchedpets[index].name!),
                        
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(catss.serchedpets[index].breed!),
                                catss.serchedpets[index].is_friendly == true ? Text('Friendly')
                                : Text('!Friendly')
                                
                              ]
                            
                            ),
                        
                          ],
                        ),
                      ),
                    );
                  }
                  
                ),
              ),
            ),
          ],
        ),
      
      ),
    );
  }
}