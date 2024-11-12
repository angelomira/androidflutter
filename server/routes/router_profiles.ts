import express,
    {
        Request,
        Response
    } from 'express';

import { PrismaClient } from '@prisma/client';
import Profile from '../models/profile';

export const ROUTER_PROFILES = express.Router();

const prisma = new PrismaClient();

ROUTER_PROFILES.get('/', async (req: Request, res: Response) => {
    const profiles = await prisma.profile.findMany();

    if(profiles) {
        res.status(200).json(profiles);
        return;
    } else {
        res.status(404).json({ message: 'Can not find profiles.' });
        return;
    }
});

ROUTER_PROFILES.get('/:id', async (req: Request, res: Response) => {
    const profile = await prisma.profile.findFirst({
        where: {
            id: Number(req.params.id)
        }
    });

    if(!profile) {
        res.status(404).json({ message: 'Profile not found.' });
        return;
    } else {
        res.status(200).json(profile);
        return;
    }
});

ROUTER_PROFILES.post('/', async (req: Request, res: Response) => {
    try {
        const item = Profile.create(req.body);

        const profile = await prisma.profile.create({
            data: {
                name: item.name,
                surname: item.surname,
                middlename: item.middlename,
                dateborn: item.dateBorn,
            }
        });
    } catch(error) {
        res.status(404).json({ message: 'Profile can not be created in the database.'});
        return;
    }
});

ROUTER_PROFILES.put('/:id', async (req: Request, res: Response) => {
    try {
        const profile = await prisma.profile.findFirst({
            where: {
                id: Number(req.params.id)
            }
        });

        const item = Profile.create(req.body);

        const updated = await prisma.profile.update({
            where: {
                id: profile!.id
            },
            data: {
                name: item.name,
                surname: item.surname,
                middlename: item.middlename ?? '',
                dateborn: item.dateBorn,
                avatarLink: item.avatarLink
            }
        });
    } catch(error) {
        res.status(404).json({ message: 'Profile can not be updated in the database.'});
        return;
    }
});

ROUTER_PROFILES.delete('/:id', async (req: Request, res: Response) => {
    try {
        const profile = await prisma.profile.delete({
            where: {
                id: Number(req.params.id)
            }
        })
    } catch(error) {
        res.status(404).json({ message: 'Profile not delete car from database.' });
        return;
    }
});