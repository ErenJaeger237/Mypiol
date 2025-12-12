import React, { useState } from 'react';
import { View, Text, StyleSheet, TextInput, ScrollView, TouchableOpacity, useColorScheme, KeyboardAvoidingView, Platform, Image } from 'react-native';
import { Stack, useRouter } from 'expo-router';
import { Ionicons } from '@expo/vector-icons';
import { Colors } from '../../constants/Colors';
import * as ImagePicker from 'expo-image-picker';

export default function AddProperty() {
    const colorScheme = useColorScheme();
    const theme = Colors[colorScheme ?? 'light'];
    const router = useRouter();

    const [title, setTitle] = useState('');
    const [price, setPrice] = useState('');
    const [address, setAddress] = useState('');
    const [description, setDescription] = useState('');
    const [image, setImage] = useState<string | null>(null);

    // Mock amenities selection
    const [amenities, setAmenities] = useState<string[]>([]);
    const AVAILABLE_AMENITIES = ['Pool', 'Gym', 'Garage', 'Garden', 'WiFi', 'AC'];

    const toggleAmenity = (amenity: string) => {
        if (amenities.includes(amenity)) {
            setAmenities(amenities.filter(a => a !== amenity));
        } else {
            setAmenities([...amenities, amenity]);
        }
    };

    const pickImage = async () => {
        // No permission request needed for launching image library in Expo 
        // (but good practice in real apps)
        let result = await ImagePicker.launchImageLibraryAsync({
            mediaTypes: ImagePicker.MediaTypeOptions.Images,
            allowsEditing: true,
            aspect: [4, 3],
            quality: 1,
        });

        if (!result.canceled) {
            setImage(result.assets[0].uri);
        }
    };

    const handleSubmit = () => {
        // In a real app, send to backend
        console.log({ title, price, address, description, amenities, image });
        alert('Property Listed Successfully!');
        router.back();
    };

    return (
        <KeyboardAvoidingView
            behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
            style={[styles.container, { backgroundColor: theme.background }]}
        >
            <Stack.Screen options={{ title: 'Add New Property', headerBackTitle: 'Back' }} />

            <ScrollView contentContainerStyle={styles.scrollContent}>

                {/* Image Upload */}
                <TouchableOpacity onPress={pickImage} style={[styles.imageUpload, { backgroundColor: theme.card, borderColor: theme.border }]}>
                    {image ? (
                        <Image source={{ uri: image }} style={styles.uploadedImage} />
                    ) : (
                        <View style={styles.uploadPlaceholder}>
                            <Ionicons name="camera-outline" size={40} color={theme.secondary} />
                            <Text style={[styles.uploadText, { color: theme.secondary }]}>Add Property Photo</Text>
                        </View>
                    )}
                </TouchableOpacity>

                <View style={styles.form}>
                    <View style={styles.section}>
                        <Text style={[styles.label, { color: theme.text }]}>Propety Details</Text>

                        <TextInput
                            placeholder="Property Title (e.g. Modern Villa)"
                            placeholderTextColor={theme.secondary}
                            style={[styles.input, { backgroundColor: theme.card, color: theme.text, borderColor: theme.border }]}
                            value={title}
                            onChangeText={setTitle}
                        />

                        <TextInput
                            placeholder="Price (FCFA)"
                            placeholderTextColor={theme.secondary}
                            keyboardType="numeric"
                            style={[styles.input, { backgroundColor: theme.card, color: theme.text, borderColor: theme.border }]}
                            value={price}
                            onChangeText={setPrice}
                        />

                        <TextInput
                            placeholder="Address / Location"
                            placeholderTextColor={theme.secondary}
                            style={[styles.input, { backgroundColor: theme.card, color: theme.text, borderColor: theme.border }]}
                            value={address}
                            onChangeText={setAddress}
                        />
                    </View>

                    <View style={styles.section}>
                        <Text style={[styles.label, { color: theme.text }]}>Description</Text>
                        <TextInput
                            placeholder="Describe the property..."
                            placeholderTextColor={theme.secondary}
                            multiline
                            numberOfLines={4}
                            style={[styles.textArea, { backgroundColor: theme.card, color: theme.text, borderColor: theme.border }]}
                            value={description}
                            onChangeText={setDescription}
                        />
                    </View>

                    <View style={styles.section}>
                        <Text style={[styles.label, { color: theme.text }]}>Amenities</Text>
                        <View style={styles.amenitiesContainer}>
                            {AVAILABLE_AMENITIES.map((item) => (
                                <TouchableOpacity
                                    key={item}
                                    style={[
                                        styles.amenityChip,
                                        amenities.includes(item)
                                            ? { backgroundColor: theme.primary, borderColor: theme.primary }
                                            : { backgroundColor: theme.card, borderColor: theme.border }
                                    ]}
                                    onPress={() => toggleAmenity(item)}
                                >
                                    <Text style={[
                                        styles.amenityText,
                                        { color: amenities.includes(item) ? 'white' : theme.text }
                                    ]}>{item}</Text>
                                </TouchableOpacity>
                            ))}
                        </View>
                    </View>

                    <TouchableOpacity
                        style={[styles.submitButton, { backgroundColor: theme.primary }]}
                        onPress={handleSubmit}
                    >
                        <Text style={styles.submitButtonText}>Publish Listing</Text>
                    </TouchableOpacity>
                </View>
            </ScrollView>
        </KeyboardAvoidingView>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
    },
    scrollContent: {
        padding: 20,
    },
    imageUpload: {
        height: 200,
        borderRadius: 16,
        borderWidth: 1,
        borderStyle: 'dashed',
        marginBottom: 24,
        overflow: 'hidden',
    },
    uploadPlaceholder: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
    },
    uploadedImage: {
        width: '100%',
        height: '100%',
    },
    uploadText: {
        marginTop: 8,
        fontWeight: '500',
    },
    form: {
        gap: 24,
    },
    section: {
        gap: 12,
    },
    label: {
        fontSize: 18,
        fontWeight: 'bold',
        marginBottom: 4,
    },
    input: {
        height: 50,
        borderRadius: 12,
        borderWidth: 1,
        paddingHorizontal: 16,
        fontSize: 16,
    },
    textArea: {
        height: 120,
        borderRadius: 12,
        borderWidth: 1,
        padding: 16,
        fontSize: 16,
        textAlignVertical: 'top',
    },
    amenitiesContainer: {
        flexDirection: 'row',
        flexWrap: 'wrap',
        gap: 8,
    },
    amenityChip: {
        paddingHorizontal: 16,
        paddingVertical: 8,
        borderRadius: 20,
        borderWidth: 1,
    },
    amenityText: {
        fontWeight: '600',
    },
    submitButton: {
        height: 56,
        borderRadius: 16,
        justifyContent: 'center',
        alignItems: 'center',
        marginTop: 16,
        marginBottom: 40,
        shadowColor: "#000",
        shadowOffset: { width: 0, height: 4 },
        shadowOpacity: 0.3,
        shadowRadius: 4.65,
        elevation: 8,
    },
    submitButtonText: {
        color: 'white',
        fontSize: 18,
        fontWeight: 'bold',
    },
});
