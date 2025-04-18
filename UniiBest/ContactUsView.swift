import SwiftUI

struct ContactUsView: View {
    @ObservedObject var navigation = Navigation.shared
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var message: String = ""
    @State var showImagePicker = false
    @State var showActionSheet = false
    @State var selectedImage: UIImage? = nil
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var showSuccessMessage = false
    
    @State private var nameError: String?
    @State private var emailError: String?
    @State private var messageError: String?
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(RoundedRectangle(cornerRadius: 28)
                        .fill(.white.opacity(0.45)))
                    .onTapGesture {
                        navigation.navigateBack()
                    }
                
                Text("Contact Us")
                    .foregroundStyle(.white)
                    .font(.system(size: 24, weight: .heavy))
                
                Spacer()
            }
            .padding()
            .background(Color("147B45"))
            
            ScrollView {
                VStack(spacing: 16) {
                    Text("On this screen, you can share your feedback with us. You can attach a photo from your gallery or take one with your camera, and write any suggestions or issues you've experienced with the app. We'll do our best to fix problems and improve your experience.")
                        .font(.caption)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    TextField("", text: $name, prompt: Text("Name").foregroundColor(Color.white.opacity(0.5)))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("147B45"))
                        .foregroundColor(.white)
                        .cornerRadius(6)
                        .padding(.horizontal)
                    
                    if let nameError = nameError {
                        Text(nameError)
                            .foregroundColor(.red)
                            .font(.caption)
                            .padding(.leading, 8)
                    }
                    
                    TextField("", text: $email, prompt: Text("Email").foregroundColor(Color.white.opacity(0.5)))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("147B45"))
                        .foregroundColor(.white)
                        .cornerRadius(6)
                        .padding(.horizontal)
                    
                    if let emailError = emailError {
                        Text(emailError)
                            .foregroundColor(.red)
                            .font(.caption)
                            .padding(.leading, 8)
                    }
                    
                    TextEditor(text: $message)
                        .padding()
                        .background(Color("147B45"))
                        .cornerRadius(6)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .scrollContentBackground(.hidden)
                        .frame(height: 150)
                        .placeholder(when: message.isEmpty) {
                            Text("Message")
                                .foregroundColor(.white.opacity(0.5))
                                .padding()
                        }
                        .padding(.horizontal)
                    
                    if let messageError = messageError {
                        Text(messageError)
                            .foregroundColor(.red)
                            .font(.caption)
                            .padding(.leading, 8)
                    }
                    
                    HStack {
                        Spacer()
                        
                        VStack(alignment: .center, spacing: 10) {
                            Text(selectedImage == nil ? "Add Image" : "Change Image")
                                .foregroundStyle(.white)
                                .font(.subheadline)
                            
                            if let image = selectedImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 50)
                                    .cornerRadius(6)
                            }
                        }
                        .padding()
                        
                        Spacer()
                    }
                    .background(
                        Color("147B45")
                    )
                    .cornerRadius(6)
                    .padding(.horizontal)
                    .onTapGesture {
                        showActionSheet = true
                    }
                    
                    Button(action: {
                        validateForm()
                    }) {
                        Text("Send Message")
                            .font(.system(size: 24, weight: .heavy))
                            .foregroundStyle(Color("111111"))
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                    }
                    .background(Color("FFE71D"))
                    .cornerRadius(6)
                    .padding()
                    
                    if showSuccessMessage {
                        Text("Thank you for your feedback. We’ll get back to you as soon as possible.")
                            .font(.subheadline)
                            .foregroundStyle(.green)
                            .multilineTextAlignment(.center)
                    }
                    
                    Spacer()
                }
            }
        }
        .actionSheet(isPresented: $showActionSheet) {
            ActionSheet(
                title: Text("Choose an option"),
                buttons: [
                    .default(Text("Camera")) {
                        sourceType = .camera
                        showImagePicker = true
                    },
                    .default(Text("Photo Library")) {
                        sourceType = .photoLibrary
                        showImagePicker = true
                    },
                    .cancel()
                ]
            )
        }
        .sheet(isPresented: $showImagePicker) {
            ContactUsImagePicker(sourceType: sourceType, selectedImage: $selectedImage)
        }
    }
    
    private func validateForm() {
        nameError = name.isEmpty ? "Name is required" : nil
        emailError = email.isEmpty ? "Email is required" : nil
        messageError = message.isEmpty ? "Message is required" : nil
        
        if nameError == nil, emailError == nil, messageError == nil {
            name = ""
            email = ""
            message = ""
            selectedImage = nil
            showSuccessMessage = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                showSuccessMessage = false
            }
        }
    }
}

#Preview {
    ContactUsView()
}

