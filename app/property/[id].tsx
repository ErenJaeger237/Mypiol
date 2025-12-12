import React from 'react';
import { View, Text, Image, StyleSheet, ScrollView, TouchableOpacity, Dimensions } from 'react-native';
import { useLocalSearchParams, useRouter } from 'expo-router';
import { Ionicons } from '@expo/vector-icons';
import { BlurView } from 'expo-blur';
import { useColorScheme } from 'react-native';
import { Colors } from '../../constants/Colors';
import { PROPERTIES } from '../../constants/MockData';

const { width, height } = Dimensions.get('window');

export default function PropertyDetails() {
    const { id } = useLocalSearchParams();
    const router = useRouter();
    const colorScheme = useColorScheme();
    const theme = Colors[colorScheme ?? 'light'];

    const property = PROPERTIES.find(p => p.id === id);

    if (!property) {
        return <View style={[styles.container, { backgroundColor: theme.background }]}><Text style={{ color: theme.text }}>Property not found</Text></View>;
    }

    return (
        <View style={[styles.container, { backgroundColor: theme.background }]}>
            <ScrollView bounces={false} showsVerticalScrollIndicator={false} contentContainerStyle={{ paddingBottom: 100 }}>
                <View style={styles.imageContainer}>
                    <Image source={{ uri: property.imageUrl }} style={styles.image} resizeMode="cover" />
                    <TouchableOpacity
                        style={styles.backButton}
                        onPress={() => router.back()}
                    >
                        <BlurView intensity={50} tint="dark" style={styles.blurIcon}>
                            <Ionicons name="arrow-back" size={24} color="#fff" />
                        </BlurView>
                    </TouchableOpacity>
                    <TouchableOpacity
                        style={styles.favoriteButton}
                    >
                        <BlurView intensity={50} tint="dark" style={styles.blurIcon}>
                            <Ionicons name="heart-outline" size={24} color="#fff" />
                        </BlurView>
                    </TouchableOpacity>
                </View>

                <View style={styles.content}>
                    <Text style={[styles.title, { color: theme.text }]}>{property.title}</Text>
                    <View style={styles.locationRow}>
                        <Ionicons name="location-outline" size={20} color={theme.secondary} />
                        <Text style={[styles.address, { color: theme.text }]}>{property.address}</Text>
                    </View>

                    <View style={styles.statsContainer}>
                        <View style={[styles.statItem, { backgroundColor: theme.card, borderColor: theme.border }]}>
                            <Ionicons name="bed-outline" size={24} color={theme.text} />
                            <Text style={[styles.statValue, { color: theme.text }]}>{property.bedrooms}</Text>
                            <Text style={[styles.statLabel, { color: theme.text }]}>Beds</Text>
                        </View>
                        <View style={[styles.statItem, { backgroundColor: theme.card, borderColor: theme.border }]}>
                            <Ionicons name="water-outline" size={24} color={theme.text} />
                            <Text style={[styles.statValue, { color: theme.text }]}>{property.bathrooms}</Text>
                            <Text style={[styles.statLabel, { color: theme.text }]}>Baths</Text>
                        </View>
                        <View style={[styles.statItem, { backgroundColor: theme.card, borderColor: theme.border }]}>
                            <Ionicons name="expand-outline" size={24} color={theme.text} />
                            <Text style={[styles.statValue, { color: theme.text }]}>{property.sqft}</Text>
                            <Text style={[styles.statLabel, { color: theme.text }]}>Sqft</Text>
                        </View>
                    </View>

                    <Text style={[styles.sectionTitle, { color: theme.text }]}>Description</Text>
                    <Text style={[styles.description, { color: theme.text }]}>{property.description}</Text>

                    <Text style={[styles.sectionTitle, { color: theme.text }]}>Amenities</Text>
                    <View style={styles.amenitiesContainer}>
                        {property.amenities.map((amenity, index) => (
                            <View key={index} style={[styles.amenityChip, { backgroundColor: theme.card, borderColor: theme.border }]}>
                                <Ionicons name="checkmark-circle-outline" size={16} color={theme.secondary} />
                                <Text style={[styles.amenityText, { color: theme.text }]}>{amenity}</Text>
                            </View>
                        ))}
                    </View>
                </View>
            </ScrollView>

            <BlurView intensity={100} tint={colorScheme === 'dark' ? 'dark' : 'light'} style={styles.bottomBar}>
                <View style={styles.priceContainer}>
                    <Text style={[styles.priceLabel, { color: theme.text }]}>Price</Text>
                    <Text style={[styles.priceValue, { color: theme.text }]}>{property.price}</Text>
                </View>
                <TouchableOpacity style={[styles.bookButton, { backgroundColor: theme.primary }]}>
                    <Text style={[styles.bookButtonText, { color: '#000' }]}>Book Viewing</Text>
                </TouchableOpacity>
            </BlurView>
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
    },
    imageContainer: {
        height: height * 0.45,
        width: '100%',
        position: 'relative',
    },
    image: {
        width: '100%',
        height: '100%',
    },
    backButton: {
        position: 'absolute',
        top: 50,
        left: 20,
        borderRadius: 20,
        overflow: 'hidden',
    },
    favoriteButton: {
        position: 'absolute',
        top: 50,
        right: 20,
        borderRadius: 20,
        overflow: 'hidden',
    },
    blurIcon: {
        padding: 10,
        borderRadius: 20,
    },
    content: {
        padding: 24,
        borderTopLeftRadius: 30,
        borderTopRightRadius: 30,
        marginTop: -30,
        backgroundColor: 'transparent',
    },
    title: {
        fontSize: 28,
        fontWeight: 'bold',
        marginBottom: 8,
    },
    locationRow: {
        flexDirection: 'row',
        alignItems: 'center',
        marginBottom: 24,
    },
    address: {
        fontSize: 16,
        marginLeft: 8,
        opacity: 0.8,
    },
    statsContainer: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        marginBottom: 32,
    },
    statItem: {
        flex: 1,
        alignItems: 'center',
        padding: 12,
        borderRadius: 16,
        borderWidth: 1,
        marginHorizontal: 4,
    },
    statValue: {
        fontSize: 18,
        fontWeight: '700',
        marginTop: 4,
    },
    statLabel: {
        fontSize: 12,
        opacity: 0.6,
    },
    sectionTitle: {
        fontSize: 20,
        fontWeight: '600',
        marginBottom: 12,
        marginTop: 8,
    },
    description: {
        fontSize: 16,
        lineHeight: 24,
        opacity: 0.8,
        marginBottom: 24,
    },
    amenitiesContainer: {
        flexDirection: 'row',
        flexWrap: 'wrap',
        gap: 10,
    },
    amenityChip: {
        flexDirection: 'row',
        alignItems: 'center',
        paddingHorizontal: 16,
        paddingVertical: 8,
        borderRadius: 20,
        borderWidth: 1,
        gap: 6,
    },
    amenityText: {
        fontWeight: '500',
    },
    bottomBar: {
        position: 'absolute',
        bottom: 0,
        left: 0,
        right: 0,
        flexDirection: 'row',
        alignItems: 'center',
        justifyContent: 'space-between',
        paddingHorizontal: 24,
        paddingVertical: 20,
        paddingBottom: 40,
        borderTopWidth: 1,
        borderTopColor: 'rgba(255,255,255,0.1)',
    },
    priceContainer: {
        flex: 1,
    },
    priceLabel: {
        fontSize: 14,
        opacity: 0.6,
    },
    priceValue: {
        fontSize: 24,
        fontWeight: 'bold',
    },
    bookButton: {
        paddingHorizontal: 24,
        paddingVertical: 14,
        borderRadius: 16,
        marginLeft: 20,
    },
    bookButtonText: {
        fontWeight: 'bold',
        fontSize: 16,
    },
});
