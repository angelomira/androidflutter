import express,
    {
        Request,
        Response
    } from 'express';

import { PrismaClient } from '@prisma/client';

export const ROUTER_FAVORITES = express.Router();

const prisma = new PrismaClient();

ROUTER_FAVORITES.get('/', async (req: Request, res: Response) => {
    try {
        const favorites = await prisma.car.findMany({
            where: {
                isFavorite: true
            }
        });

        res.status(200).json(favorites);
        return;
    } catch(error) {
        res.status(404).json({ message: 'Can not find favorites cars.' });
        return;
    }
});

ROUTER_FAVORITES.put('/:id', async (req: Request, res: Response) => {
    try {
        const car = await prisma.car.findFirst({
            where: {
                id: Number(req.params.id)
            }
        });

        const update = await prisma.car.update({
            where: {
                id: car!.id
            },
            data: {
                isFavorite: !car!.isFavorite
            }
        });
    } catch(error) {
        res.status(404).json({ message: 'Car not found.' });
        return;
    }
});