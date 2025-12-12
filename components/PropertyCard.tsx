import React from 'react';
import { StyleSheet, View, Text, Image, Pressable, Dimensions, useColorScheme } from 'react-native';
import { Link, useRouter } from 'expo-router';
import { Ionicons } from '@expo/vector-icons';
import { Colors } from '../constants/Colors';
import { Property } from '../constants/MockData';

const { width } = Dimensions.get('window');

interface Props {
    property: Property;
}

export default function PropertyCard({ property }: Props) {
    const router = useRouter();
    const colorScheme = useColorScheme();
    const theme = Colors[colorScheme ?? 'light'];

    const handlePress = () => {
        router.push(`/property/${property.id}`);
    };

    return (
        <Pressable
            onPress={handlePress}
            style={({ pressed }) => [
                styles.container,
                { backgroundColor: theme.card, opacity: pressed ? 0.95 : 1, transform: [{ scale: pressed ? 0.98 : 1 }] }
            ]}
        >
            <View style={styles.imageContainer}>
                <Image source={{ uri: property.imageUrl }} style={styles.image} resizeMode="cover" />
                <View style={styles.priceTag}>
                    <Text style={styles.priceText}>{property.price}</Text>
                </View>
                <Pressable style={styles.favoriteButton}>
                    <Ionicons name="heart-outline" size={24} color="#fff" />
                </Pressable>
            </View>

            <View style={styles.content}>
                <Text style={[styles.title, { color: theme.text }]} numberOfLines={1}>{property.title}</Text>
                <View style={styles.locationRow}>
                    <Ionicons name="location-outline" size={16} color={theme.secondary} />
                    <Text style={[styles.address, { color: theme.text }]} numberOfLines={1}> {property.address}</Text>
                </View>

                <View style={styles.featuresRow}>
                    <View style={styles.featureItem}>
                        <Ionicons name="bed-outline" size={18} color={theme.text} />
                        <Text style={[styles.featureText, { color: theme.text }]}> {property.bedrooms} Beds</Text>
                    </View>
                    <View style={styles.featureItem}>
                        <Ionicons name="water-outline" size={18} color={theme.text} />
                        <Text style={[styles.featureText, { color: theme.text }]}> {property.bathrooms} Baths</Text>
                    </View>
                    <View style={styles.featureItem}>
                        <Ionicons name="expand-outline" size={18} color={theme.text} />
                        <Text style={[styles.featureText, { color: theme.text }]}> {property.sqft} sqft</Text>
                    </View>
                </View>
            </View>
        </Pressable>
    );
}

const styles = StyleSheet.create({
    container: {
        borderRadius: 16,
        marginBottom: 20,
        overflow: 'hidden',
        shadowColor: '#000',
        shadowOffset: { width: 0, height: 4 },
        shadowOpacity: 0.1,
        shadowRadius: 12,
        elevation: 5,
        marginHorizontal: 20,
    },
    imageContainer: {
        height: 220,
        width: '100%',
        position: 'relative',
    },
    image: {
        width: '100%',
        height: '100%',
    },
    priceTag: {
        position: 'absolute',
        bottom: 16,
        left: 16,
        backgroundColor: 'rgba(0,0,0,0.7)',
        paddingVertical: 6,
        paddingHorizontal: 12,
        borderRadius: 8,
    },
    priceText: {
        color: '#fff',
        fontWeight: 'bold',
        fontSize: 16,
    },
    favoriteButton: {
        position: 'absolute',
        top: 16,
        right: 16,
        backgroundColor: 'rgba(0,0,0,0.3)',
        borderRadius: 20,
        padding: 8,
    },
    content: {
        padding: 16,
    },
    title: {
        fontSize: 20,
        fontWeight: '700',
        marginBottom: 8,
    },
    locationRow: {
        flexDirection: 'row',
        alignItems: 'center',
        marginBottom: 16,
        opacity: 0.7,
    },
    address: {
        fontSize: 14,
        marginLeft: 4,
    },
    featuresRow: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        paddingTop: 12,
        borderTopWidth: 1,
        borderTopColor: '#eee',
    },
    featureItem: {
        flexDirection: 'row',
        alignItems: 'center',
    },
    featureText: {
        fontSize: 14,
        fontWeight: '500',
        marginLeft: 4,
    },
});
