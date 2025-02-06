import 'dart:io';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart';

class RecordingsScreen extends StatefulWidget {
  @override
  _RecordingsScreenState createState() => _RecordingsScreenState();
}

class _RecordingsScreenState extends State<RecordingsScreen> {
  final AudioRecorder _audioRecorder = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isRecording = false;
  List<String> _recordings = [];

  @override
  void initState() {
    super.initState();
    _loadRecordings();
  }

  Future<String> _getFilePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return "${dir.path}/recording_${DateTime.now().millisecondsSinceEpoch}.m4a";
  }

  Future<void> _loadRecordings() async {
    final dir = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> files = Directory(dir.path).listSync();
    setState(() {
      _recordings = files
          .where((file) => file.path.endsWith(".m4a"))
          .map((file) => file.path)
          .toList();
    });
  }

  Future<void> _startRecording() async {
    if (await Permission.microphone.request().isGranted) {
      final filePath = await _getFilePath();
      try {
        await _audioRecorder.start(const RecordConfig(), path: filePath);
        setState(() {
          _isRecording = true;
        });
      } catch (e) {
        print("Error starting recording: $e");
      }
    } else {
      print("Microphone permission denied");
    }
  }

  Future<void> _stopRecording() async {
    try {
      final path = await _audioRecorder.stop();
      if (path != null) {
        setState(() {
          _isRecording = false;
          _recordings.add(path);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Recording saved: $path")),
        );
      }
    } catch (e) {
      print("Error stopping recording: $e");
    }
  }

  void _playRecording(String filePath) async {
    await _audioPlayer.play(DeviceFileSource(filePath));
  }

  void _deleteRecording(String filePath) {
    File(filePath).delete();
    setState(() {
      _recordings.remove(filePath);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Recording deleted")),
    );
  }

  @override
  void dispose() {
    _audioRecorder.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Audio Recorder")),
      body: Column(
        children: [
          Expanded(
            child: _recordings.isEmpty
                ? Center(child: Text("No recordings found"))
                : ListView.builder(
              itemCount: _recordings.length,
              itemBuilder: (context, index) {
                String filePath = _recordings[index];
                return Card(
                  child: ListTile(
                    title: Text("Recording ${index + 1}"),
                    subtitle: Text(filePath),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.play_arrow, color: Colors.green),
                          onPressed: () => _playRecording(filePath),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteRecording(filePath),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(_isRecording ? Icons.stop : Icons.mic),
        backgroundColor: _isRecording ? Colors.red : Colors.blue,
        onPressed: _isRecording ? _stopRecording : _startRecording,
      ),
    );
  }
}
