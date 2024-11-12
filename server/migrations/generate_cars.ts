// seed.js

import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
    const cars = [
        {
            id: 0,
            carName: 'Ford \nBoss-302',
            carEntry: '1970',
            price: '95,000 (OBO)',
            linkImage: 'https://photos.classiccars.com/cc-temp/listing/188/2595/48446195-1970-ford-mustang-boss-302-thumb.jpg',
            linkRefer: 'https://classiccars.com/listings/view/1882595/1970-ford-mustang-boss-302-for-sale-in-carlsbad-california-92008',
            carDescription: 'I’m offering my stunning 1970 Ford Mustang Boss 302, one of only 241 produced in the iconic Grabber Green color. This classic muscle car has been meticulously maintained and comes with an Elite Marti Report that took a year to obtain, proving its rarity and authenticity.',
            isFavorite: false
        },
        {
            id: 1,
            carName: 'Plymouth \nSatellite',
            carEntry: '1965',
            price: '34,550 (OBO)',
            linkImage: 'https://photos.classiccars.com/cc-temp/listing/157/4042/30723899-1965-plymouth-satellite-thumb.jpg',
            linkRefer: 'https://classiccars.com/listings/view/1574042/1965-plymouth-satellite-for-sale-in-peoria-arizona-85383',
            carDescription: 'Interior and paint are flawless, body never rusty chrome like new, very detailed restoration runs and drives as new. original chrome dress up engine package (even the original air filter service decal is still intact!), build sheet, Redline tires, 1966 only wide wheel option hub caps (less than 100 miles on these since new)',
            isFavorite: false
        },
        {
            id: 2,
            carName: 'Chevrolet \nCorvette',
            carEntry: '1962',
            price: '139,900 (OBO)',
            linkImage: 'https://photos.classiccars.com/cc-temp/listing/187/6436/48063820-1962-chevrolet-corvette-thumb.jpg',
            linkRefer: 'https://classiccars.com/listings/view/1876436/1962-chevrolet-corvette-for-sale-in-mission-viejo-california-92692-1868',
            carDescription: 'Complete Body off Rotisserie Restoration with limited edition Chevrolet 350 cubic inch, ZZ430, Small Block Crate Engine (Only 430 ZZ430s were made!), Richmond 4 Speed Transmission, Ford 9” Posi Traction Rear End with 350 Gears.',
            isFavorite: false
        },
        {
            id: 3,
            carName: 'Ford \nThunderbird',
            carEntry: '1957',
            price: '200,000 (OBO)',
            linkImage: 'https://photos.classiccars.com/cc-temp/listing/188/3755/48518682-1957-ford-thunderbird-sports-roadster-thumb.jpg',
            linkRefer: 'https://classiccars.com/listings/view/1883755/1957-ford-thunderbird-sports-roadster-for-sale-in-laguna-woods-california-92637',
            carDescription: 'This is a complete build from frame up. Art Morrison chassis four link coil overs on all four corners wellwood disc brakes, rack and pinion steering, LS3 crate engine 430 hp, air conditioning, chassis powder coated dark blue, engine painted dark blue.',
            isFavorite: false
        },
        {
            id: 4,
            carName: 'Chevrolet \nCorvette',
            carEntry: '1976',
            price: '5,700 (USD)',
            linkImage: 'https://photos.autohunter.com/assets/media/32e4dec0-af36-45cd-a7c8-296788a47b1d_largesize.jpg',
            linkRefer: 'https://autohunter.com/Listing/Details/57703493/1976-CHEVROLET-CORVETTE-L48',
            carDescription: 'If a bid is placed within the last minute of an auction, an additional minute is added to ensure all bidders have a fair chance to bid. Bid carefully. Please complete your vehicle due-diligence prior to bidding. Bids are binding and by placing your bid you agree to our User Agreement and Privacy Policy.',
            isFavorite: false
        },
        {
            id: 5,
            carName: 'Willys-Knight \nModel',
            carEntry: '1928',
            price: '20,000 (OBO)',
            linkImage: 'https://photos.classiccars.com/cc-temp/listing/175/3051/40782979-1928-willys-knight-model-56-thumb.jpg',
            linkRefer: 'https://classiccars.com/listings/view/1753051/1928-willys-knight-model-56-for-sale-in-rye-colorado-81069',
            carDescription: 'This Willys Knight is a total body off restoration and engine was rebuilt has less than 1,000 miles a. This car was in a museum for a few years, probably the best condition of any Willys Knight in the United States. Engine runs strong, transmission is good, tires and wood spoke wheels perfect condition. Gauges work. Very rare find, show quality. Clean title.',
            isFavorite: false
        },
        {
            id: 6,
            carName: 'Lincoln \nContinental',
            carEntry: '1963',
            price: '125,000 (OBO)',
            linkImage: 'https://photos.classiccars.com/cc-temp/listing/179/9616/43410791-1963-lincoln-continental-thumb.jpg',
            linkRefer: 'https://classiccars.com/listings/view/1799616/1963-lincoln-continental-for-sale-in-san-diego-california-92101',
            carDescription: 'Properly restored early 1960s slab-sided Lincoln sedans are indeed rare. While more numerous by far than the convertibles, most were not well cared for and driven to unrestorable condition and many were sacrificed as parts cars many years ago. The car presented was purchased by a Lincoln Club owner and has been received a "no expense spared" restoration based upon what was believed to be a dowdy 27,000-mile unrestored vehicle, complete with all original parts except tires and wheel rims (converted at some point to 15-inch wheels and then restored back to factory correct 14 inches.)',
            isFavorite: false,
        }
    ];

    cars.forEach(async (car) => {
        await prisma.car.create({
            data: {
                id: car.id,
                carName: car.carName!,
                carEntry: car.carEntry!,
                price: car.price,
                linkImage: car.linkImage!,
                linkRefer: car.linkRefer!,
                carDescription: car.carDescription!,
                isFavorite: car.isFavorite
            }
        });
    });
}

main()
    .catch(e => {
        console.error(e);
        process.exit(1);
    })
    .finally(async () => {
        await prisma.$disconnect();

        console.debug(`${Date.now()} - Inserted cars data!`);
    });