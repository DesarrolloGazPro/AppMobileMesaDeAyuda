import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mesadeayuda/src/page/menu/list/tickets/menu_list_tickets_controller.dart';
import 'package:mesadeayuda/src/utils/my_colors.dart';

class MenuListTicketsPage extends StatefulWidget {
  const MenuListTicketsPage({super.key});

  @override
  State<MenuListTicketsPage> createState() => _MenuListTicketsPageState();
}

class _MenuListTicketsPageState extends State<MenuListTicketsPage> {
  MenuListTicketsController _con = new MenuListTicketsController();
  @override
  void initState(){
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context,refresh);
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.key,
      appBar: AppBar(
        leading: _menuDrawer(),
      ),
      drawer: _drawer(),
      body: Center( 
        child: ElevatedButton(
          onPressed: _con.logout, 
          child: Text('Cerrar session')),
      ),
    );
  }
  
  Widget _menuDrawer(){
    return GestureDetector( 
      onTap: _con.openDrawer,
      child: Container(
        margin: EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Image.asset('assets/img/menu.png', width: 20, height: 20,),
      ),
    );
  }

  Widget _drawer(){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: MyColors.primaryColor
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _con.userLogin.usuarios?.nombre ?? '',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                  maxLines: 1,
                ),
                Text(
                  'Email',
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade300,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic
                  ),
                  maxLines: 1,
                ),

                Text(
                  'Telefono',
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade300,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic
                  ),
                  maxLines: 1,
                ),
                Container(
                  height: 60,
                  margin: const EdgeInsets.only(top: 1),
                  child: const FadeInImage(
                    image: AssetImage('assets/img/waze.png'),
                    fadeInDuration: Duration(milliseconds: 50),
                    placeholder: AssetImage('assets/img/waze.png'),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            onTap: _con.gotoUpdateTicketPage,
            title: Text('Tickets'),
           // trailing: Icon(Icons.airplane_ticket) ,
            leading: Icon(Icons.airplane_ticket),
          ),
          ListTile(
            title: Text('Cerrar session'),
            // trailing: Icon(Icons.airplane_ticket) ,
            leading: Icon(Icons.power_settings_new),
          ),
        ],
      ),
    );
  }

  void refresh(){
    setState(() {});
  }
}

