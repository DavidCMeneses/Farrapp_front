import 'package:farrap/domain/entities/establishment_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomCard extends StatelessWidget {
  final EstablishmentCard establishmentCard;
  const CustomCard({super.key, required this.establishmentCard});

  @override
  Widget build(BuildContext context) {
    const borderRadius = Radius.circular(15);

    final color = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(borderRadius),
          border: Border.all(color: const Color(0xFFE0E0E0)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10,
                offset: const Offset(0, 5))
          ]),
      height: 330,
      width: MediaQuery.of(context).size.width - 40,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Imagen
          SizedBox(
            width: MediaQuery.of(context).size.width - 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: GestureDetector(
                onTap: () => context.push('/establishment/${establishmentCard.id}'),
                child: FadeInImage(
                    height: 180,
                    width: MediaQuery.of(context).size.width - 20,
                    fit: BoxFit.cover,
                    placeholder:
                        const AssetImage('assets/loaders/bottle-loader.gif'),
                    image: NetworkImage(establishmentCard.imageUrl)),
              ),
            ),
          ),
          //Título
          Container(
            margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
            child: Text(
              establishmentCard.name,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Bree Serif',
                  fontSize: 22),
            ),
          ),
          //Descripción básica (tipo, ciudad, etc)
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: [
                          const Icon(Icons.star_rate),
                          const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10)),
                          Expanded(
                              child: Text(establishmentCard.rating.toString())),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(establishmentCard.currentSong.name,
                                    style: const TextStyle(
                                        color: Color(0xFF3E0A57))),
                                Text(establishmentCard.currentSong.author)
                              ],
                            ),
                          ),
                          //Boton de música
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.headset),
                              style: IconButton.styleFrom(
                                  backgroundColor: color.background),
                              color: color.primary
                              //color: Colors.white,
                              ),
                        ],
                      ),
                    ),

                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(establishmentCard.preference)),
                    //Text(establishmentCard.address + ' ' + establishmentCard.city),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: RichText(
                        text: TextSpan(
                          text: establishmentCard.address,
                          style: const TextStyle(color: Color(0xFF9E95A2)),
                          children: <TextSpan>[
                            const TextSpan(
                                text: ' - ',
                                style: TextStyle(color: Color(0xFF9E95A2))),
                            TextSpan(
                                text: establishmentCard.city,
                                style:
                                    const TextStyle(color: Color(0xFF3E0A57))),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
