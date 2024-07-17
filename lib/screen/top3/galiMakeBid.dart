import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Billa/model/StarlineGame.dart';
import 'package:Billa/model/mainGame.dart';
import 'package:Billa/screen/header/appbar.dart';
import 'package:Billa/screen/top3/controller/MakeBit_controller.dart';

import '../../model/GaliGame.dart';

class GaliMakeBidPage extends StatelessWidget {
  final String? title;
  final dynamic allData;
  final dynamic whicGameName;
  GaliMakeBidPage({Key? key, this.title, required this.allData, this.whicGameName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MakeBiteController controller = Get.put(MakeBiteController(
        allData: allData, whicGameName: this.whicGameName, gameType: title));

    return Scaffold(
      appBar:
          CustomAppBar(title: title?.replaceAll('_', ' ').toUpperCase() ?? ''),
      body: GetBuilder<MakeBiteController>(
        builder: (controller) => GaliMakeBidScreen(
            controller: controller,
            gameType: title,
            allData: allData,
            whicGameName: whicGameName),
      ),
    );
  }
}

class GaliMakeBidScreen extends StatelessWidget {
  final String? gameType;
  final dynamic allData;
  final dynamic whicGameName;
  final MakeBiteController controller;

GaliMakeBidScreen(
      {Key? key,
      required this.allData,
      required this.gameType,
      required this.whicGameName,
      required this.controller})
      : super(key: key);

  final List<String> singleDigit = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9'
  ];
  final List<String> jodiDigit = [
    '00',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31',
    '32',
    '33',
    '34',
    '35',
    '36',
    '37',
    '38',
    '39',
    '40',
    '41',
    '42',
    '43',
    '44',
    '45',
    '46',
    '47',
    '48',
    '49',
    '50',
    '51',
    '52',
    '53',
    '54',
    '55',
    '56',
    '57',
    '58',
    '59',
    '60',
    '61',
    '62',
    '63',
    '64',
    '65',
    '66',
    '67',
    '68',
    '69',
    '70',
    '71',
    '72',
    '73',
    '74',
    '75',
    '76',
    '77',
    '78',
    '79',
    '80',
    '81',
    '82',
    '83',
    '84',
    '85',
    '86',
    '87',
    '88',
    '89',
    '90',
    '91',
    '92',
    '93',
    '94',
    '95',
    '96',
    '97',
    '98',
    '99'
  ];
  final List<String> singlePanna = [
    '120',
    '123',
    '124',
    '125',
    '126',
    '127',
    '128',
    '129',
    '130',
    '134',
    '135',
    '136',
    '137',
    '138',
    '139',
    '140',
    '145',
    '146',
    '147',
    '148',
    '149',
    '150',
    '156',
    '157',
    '158',
    '159',
    '160',
    '167',
    '168',
    '169',
    '170',
    '178',
    '179',
    '180',
    '189',
    '190',
    '230',
    '234',
    '235',
    '236',
    '237',
    '238',
    '239',
    '240',
    '245',
    '246',
    '247',
    '248',
    '249',
    '250',
    '256',
    '257',
    '258',
    '259',
    '260',
    '267',
    '268',
    '269',
    '270',
    '278',
    '279',
    '280',
    '289',
    '290',
    '340',
    '345',
    '346',
    '347',
    '348',
    '349',
    '350',
    '356',
    '357',
    '358',
    '359',
    '360',
    '367',
    '368',
    '369',
    '370',
    '378',
    '379',
    '380',
    '389',
    '390',
    '450',
    '456',
    '457',
    '458',
    '459',
    '460',
    '467',
    '468',
    '469',
    '470',
    '478',
    '479',
    '480',
    '489',
    '490',
    '560',
    '567',
    '568',
    '569',
    '570',
    '578',
    '579',
    '580',
    '589',
    '590',
    '670',
    '678',
    '679',
    '680',
    '689',
    '690',
    '780',
    '789',
    '790',
    '890'
  ];
  final List<String> doublePanna = [
    '100',
    '110',
    '112',
    '113',
    '114',
    '115',
    '116',
    '117',
    '118',
    '119',
    '122',
    '133',
    '144',
    '155',
    '166',
    '177',
    '188',
    '199',
    '200',
    '220',
    '223',
    '224',
    '225',
    '226',
    '227',
    '228',
    '229',
    '233',
    '244',
    '255',
    '266',
    '277',
    '288',
    '299',
    '300',
    '330',
    '334',
    '335',
    '336',
    '337',
    '338',
    '339',
    '344',
    '355',
    '366',
    '377',
    '388',
    '399',
    '400',
    '440',
    '445',
    '446',
    '447',
    '448',
    '449',
    '455',
    '466',
    '477',
    '488',
    '499',
    '500',
    '550',
    '556',
    '557',
    '558',
    '559',
    '566',
    '577',
    '588',
    '599',
    '600',
    '660',
    '667',
    '668',
    '669',
    '677',
    '688',
    '699',
    '700',
    '770',
    '778',
    '779',
    '788',
    '799',
    '800',
    '880',
    '889',
    '899',
    '900',
    '990'
  ];
  final List<String> triplePanna = [
    '000',
    '111',
    '222',
    '333',
    '444',
    '555',
    '666',
    '777',
    '888',
    '999'
  ];

  final List<String> panna = [
    '000',
    '100',
    '110',
    '111',
    '112',
    '113',
    '114',
    '115',
    '116',
    '117',
    '118',
    '119',
    '120',
    '122',
    '123',
    '124',
    '125',
    '126',
    '127',
    '128',
    '129',
    '130',
    '133',
    '134',
    '135',
    '136',
    '137',
    '138',
    '139',
    '140',
    '144',
    '145',
    '146',
    '147',
    '148',
    '149',
    '150',
    '155',
    '156',
    '157',
    '158',
    '159',
    '160',
    '166',
    '167',
    '168',
    '169',
    '170',
    '177',
    '178',
    '179',
    '180',
    '188',
    '189',
    '190',
    '199',
    '200',
    '220',
    '222',
    '223',
    '224',
    '225',
    '226',
    '227',
    '228',
    '229',
    '230',
    '233',
    '234',
    '235',
    '236',
    '237',
    '238',
    '239',
    '240',
    '244',
    '245',
    '246',
    '247',
    '248',
    '249',
    '250',
    '255',
    '256',
    '257',
    '258',
    '259',
    '260',
    '266',
    '267',
    '268',
    '269',
    '270',
    '277',
    '278',
    '279',
    '280',
    '288',
    '289',
    '290',
    '299',
    '300',
    '330',
    '333',
    '334',
    '335',
    '336',
    '337',
    '338',
    '339',
    '340',
    '344',
    '345',
    '346',
    '347',
    '348',
    '349',
    '350',
    '355',
    '356',
    '357',
    '358',
    '359',
    '360',
    '366',
    '367',
    '368',
    '369',
    '370',
    '377',
    '378',
    '379',
    '380',
    '388',
    '389',
    '390',
    '399',
    '400',
    '440',
    '444',
    '445',
    '446',
    '447',
    '448',
    '449',
    '450',
    '455',
    '456',
    '457',
    '458',
    '459',
    '460',
    '466',
    '467',
    '468',
    '469',
    '470',
    '477',
    '478',
    '479',
    '480',
    '488',
    '489',
    '490',
    '499',
    '500',
    '550',
    '555',
    '556',
    '557',
    '558',
    '559',
    '560',
    '566',
    '567',
    '568',
    '569',
    '570',
    '577',
    '578',
    '579',
    '580',
    '588',
    '589',
    '590',
    '599',
    '600',
    '660',
    '666',
    '667',
    '668',
    '669',
    '670',
    '677',
    '678',
    '679',
    '680',
    '688',
    '689',
    '690',
    '699',
    '700',
    '770',
    '777',
    '778',
    '779',
    '780',
    '788',
    '789',
    '790',
    '799',
    '800',
    '880',
    '888',
    '889',
    '890',
    '899',
    '900',
    '990',
    '999'
  ];

  List<String> _getDropdownList(String gameType) {
    switch (gameType) {
      case 'single_digit':
        return singleDigit;
      case 'jodi_digit':
        return jodiDigit;
      case 'singl_panna':
        return singlePanna;
      case 'double_panna':
        return doublePanna;
      case 'triple_panna':
        return triplePanna;

      default:
        return panna;
    }
  }

void _deleteBid(int index) {
    controller.bids.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 900,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Today Date',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              const SizedBox(height: 4),
              Text(
                DateTime.now().toString().split(' ')[0],
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Session Type',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 16),
              //===============//
        

              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: DropDownField(
                        value: controller.selectedDigit!.value.isEmpty
                            ? null
                            : controller.selectedDigit!.value,
                        required: true,
                        strict: true,
                        labelText: 'Digit Name *',
                        items: _getDropdownList(gameType!).map((String value) {
                          return value;
                        }).toList(),
                        onValueChanged: (dynamic newValue) {
                          controller.selectedDigit!.value = newValue!;
                        }),
                  ),
                  // Expanded(
                  //   child: DropdownButton<String>(
                  //     value: controller.selectedDigit!.value.isEmpty
                  //         ? null
                  //         : controller.selectedDigit!.value,
                  //     hint: const Text('Select Digit'),
                  //     items: _getDropdownList(gameType!).map((String value) {
                  //       return DropdownMenuItem<String>(
                  //         value: value,
                  //         child: Text(value),
                  //       );
                  //     }).toList(),
                  //     onChanged: (newValue) {
                  //       controller.selectedDigit!.value = newValue!;
                  //     },
                  //   ),
                  // ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller:  controller.pointController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Point',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed:controller. addBid,
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.black,
                  backgroundColor: Colors.red[900],
                ),
                child: const Text('Add', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 16),
              Container(
                color: Colors.red[800],
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: const Row(
                  children: [
                    Expanded(
                        child: Text('Digit',
                            style: TextStyle(color: Colors.white))),
                    Expanded(
                        child: Text('Point',
                            style: TextStyle(color: Colors.white))),
                    Expanded(
                        child: Text('Type',
                            style: TextStyle(color: Colors.white))),
                    Expanded(
                        child: Text('Delete',
                            style: TextStyle(color: Colors.white))),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.bids.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                            'Digit: ${controller.bids[index]['open_digit']} | Point: ${controller.bids[index]['bid_points']}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteBid(index),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text('Total Bids: ${controller.bids.length}'),
                  ),
                  Expanded(
                    child: Text(
                        'Total Point: ${controller.bids.fold<int>(0, (sum, bid) => sum + int.parse(bid['bid_points'] ?? '0'))}'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  controller.fetchWinStatement(gameName: whicGameName);
                },
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.black,
                  backgroundColor: Colors.red[900],
                ),
                child:
                    const Text('Submit', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}