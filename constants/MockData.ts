export interface Property {
    id: string;
    title: string;
    price: string;
    address: string;
    bedrooms: number;
    bathrooms: number;
    sqft: number;
    imageUrl: string;
    description: string;
    amenities: string[];
    rating: number;
}

export const PROPERTIES: Property[] = [
    {
        id: '1',
        title: 'Modern Glass Villa',
        price: 'FCFA 2,500,000',
        address: '123 Highland Ave, Beverly Hills, CA',
        bedrooms: 4,
        bathrooms: 3.5,
        sqft: 3200,
        imageUrl: 'https://images.unsplash.com/photo-1600596542815-22b5c1275efb?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        description: 'Experience the pinnacle of modern living in this stunning glass villa. Featuring panoramic views, an infinity pool, and smart home technology throughout.',
        amenities: ['Pool', 'Smart Home', 'Garage', 'Garden', 'Gym'],
        rating: 4.8,
    },
    {
        id: '2',
        title: 'Minimalist Urban Loft',
        price: 'FCFA 850,000',
        address: '456 Downtown Blvd, Seattle, WA',
        bedrooms: 2,
        bathrooms: 2,
        sqft: 1500,
        imageUrl: 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        description: 'A sleek, industrial-style loft in the heart of the city. High ceilings, exposed brick, and floor-to-ceiling windows make this a unique find.',
        amenities: ['Rooftop Access', 'Concierge', 'Pet Friendly'],
        rating: 4.5,
    },
    {
        id: '3',
        title: 'Seaside Retreat',
        price: 'FCFA 4,200,000',
        address: '789 Ocean Dr, Malibu, CA',
        bedrooms: 5,
        bathrooms: 5,
        sqft: 4500,
        imageUrl: 'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        description: 'Direct beach access and breathtaking ocean sunsets. This expansive estate is the ultimate getaway for relaxation and luxury.',
        amenities: ['Private Beach', 'Home Theater', 'Wine Cellar', 'Infinity Pool'],
        rating: 4.9,
    },
    {
        id: '4',
        title: 'Contemporary Forest Cabin',
        price: 'FCFA 650,000',
        address: '101 Pine Way, Portland, OR',
        bedrooms: 3,
        bathrooms: 2,
        sqft: 1800,
        imageUrl: 'https://images.unsplash.com/photo-1600093463592-8e36ae95ef56?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        description: 'Nestled in the trees, this contemporary cabin offers peace and quiet with all modern conveniences.',
        amenities: ['Fireplace', 'Deck', 'Hiking Trails'],
        rating: 4.6,
    },
];
