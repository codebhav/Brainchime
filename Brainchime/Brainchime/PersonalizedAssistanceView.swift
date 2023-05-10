import SwiftUI

struct PersonalizedAssistanceView: View {

    @State private var messages: [Message] = []
    @State private var currentMessage: String = ""

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .trailing, spacing: 10) {
                    ForEach(messages, id: \.id) { message in
                        Text(message.text)
                            .padding(10)
                            .background(message.isFromUser ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .frame(maxWidth: .infinity, alignment: message.isFromUser ? .trailing : .leading)
                            .padding(.horizontal, 10)
                    }
                }
            }

            HStack {
                TextField("Type your message", text: $currentMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(8)

                Button(action: {
                    // Send button action
                    messages.append(Message(text: currentMessage, isFromUser: true))
                    sendMessageToChatbot(message: currentMessage)
                    currentMessage = ""
                }, label: {
                    Text("Send")
                        .padding(8)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                })
            }
            .padding()
        }
    }

    func sendMessageToChatbot(message: String) {
        let apiKey = "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"
        let endpoint = "https://api.openai.com/v1/completions"
        let headers = ["Content-Type": "application/json", "Authorization": "Bearer \(apiKey)"]
        let parameters: [String: Any] = ["prompt": message, "max_tokens": 2000, "temperature": 0.7, "n": 1, "model": "text-davinci-003"]

        guard let url = URL(string: endpoint) else {
            print("Invalid endpoint URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Response from ChatGPT API: \(responseString)")
                    let botResponse = parseBotResponse(from: data)
                    DispatchQueue.main.async {
                        messages.append(Message(text: botResponse, isFromUser: false))
                    }
                }
            } else if let error = error {
                print("Error from ChatGPT API: \(error.localizedDescription)")
            }
        }.resume()
    }

    func parseBotResponse(from data: Data) -> String {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            if let choices = json?["choices"] as? [[String: Any]], let text = choices[0]["text"] as? String {
                return text.trimmingCharacters(in: .whitespacesAndNewlines)
            } else {
                return "Sorry, I couldn't understand that"
            }
        } catch {
            print("Error parsing ChatGPT API response: \(error.localizedDescription)")
            return ""
        }
    }
}

struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isFromUser: Bool
}

struct PersonalizedAssistanceView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalizedAssistanceView()
    }
}
