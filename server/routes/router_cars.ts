import express,
    {
        Request,
        Response
    } from 'express';

import Car from './../models/car';

import { PrismaClient } from '@prisma/client';

export const ROUTER_CARS = express.Router();

const prisma = new PrismaClient();

ROUTER_CARS.get('/', async (req: Request, res: Response) => {
    const cars = await prisma.car.findMany();

    if(!cars) {
        res.status(404).json({ message: 'Cars not found.'});
        return;
    }
    else {
        res.status(200).json(cars);
        return;
    }
})

ROUTER_CARS.get('/:id', async (req: Request, res: Response) => {
    const car = await prisma.car.findFirst({
        where: {
            id: Number(req.params.id)
        }
    });


    if (!car) {
        res.status(404).json({ message: 'Car not found.' });
        return;
    } else {
        res.status(200).json(car);
        return;
    }
});

ROUTER_CARS.get('/:starts/:ending', async (req: Request, res: Response) => {
    const cars = await prisma.car.findMany();

    const arrange = cars.slice(
        Number(req.params.starts),
        Number(req.params.ending)
    );

    if(arrange) {
        res.status(200).json(arrange);
        return;
    }
    else {
        res.status(404).json({ message: 'Can not get range of cars from database.' });
        return;
    }
});

ROUTER_CARS.post('/', async (req: Request, res: Response) => {
    try {
        /* Parsing data through JS models for cleaner code. */
        const item = Car.create(req.body);

        const car = await prisma.car.create({
            data: {
                carName: item.carName,
                carEntry: item.carEntry,
                price: item.price,
                linkImage: item.linkImage,
                linkRefer: item.linkRefer,
                carDescription: item.carDescription,
                isFavorite: item.isFavorite
            }
        });
    } catch(error) {
        res.status(404).json({ message: 'Car can not be created in the database.'});
        return;
    }
});

ROUTER_CARS.put('/:id', async (req: Request, res: Response) => {
    try {
        /* Parsing data through JS models for cleaner code. */
        const item = Car.create(req.body);

        const car = await prisma.car.update({
            where: {
                id: Number(req.params.id)
            },
            data: {
                carName: item.carName,
                carEntry: item.carEntry,
                price: item.price,
                linkImage: item.linkImage,
                linkRefer: item.linkRefer,
                carDescription: item.carDescription,
                isFavorite: item.isFavorite
            }
        });
    } catch(error) {
        res.status(404).json({ message: 'Car not found.' });
        return;
    }
});

ROUTER_CARS.delete('/:id', async (req: Request, res: Response) => {
    try {
        const car = await prisma.car.delete({
            where: {
                id: Number(req.params.id)
            }
        });
    } catch(error) {
        res.status(404).json({ message: 'Car not found.' });
        return;
    }
});