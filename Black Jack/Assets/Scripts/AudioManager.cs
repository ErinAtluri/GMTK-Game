using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using UnityEngine.UI;

public class AudioManager : MonoBehaviour
{
    public Sound[] sounds;
    [SerializeField] private Slider volumeControl;

    void Start()
    {

        foreach (Sound s in sounds)
        {
            s.source = gameObject.AddComponent<AudioSource>();
            s.source.clip = s.clip;
            s.source.volume = s.volume;
            s.source.pitch = s.pitch;
            s.source.loop = s.loop;
        }
        //SlideChanged();


    }


    public void SlideChanged()
    {
        for (int s = 0; s < sounds.Length; s++)
        {
            sounds[s].source.volume = volumeControl.value;
        }
    }

    public void Play(string name)
    {
        Sound s = Array.Find(sounds, sound => sound.name == name);
        if (s == null)
        {
            return;
        }
        s.source.Play();
    }

    public void PlayIndex(int index)
    {

        sounds[index].source.Play();
    }

    public bool checkSound(int index)
    {
        if (sounds[index].source.isPlaying)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    public void Stop(string name)
    {
        Sound s = Array.Find(sounds, sound => sound.name == name);
        if (s == null)
        {
            return;
        }
        s.source.Stop();
    }

    public void NoVolume(string name)
    {
        Sound s = Array.Find(sounds, sound => sound.name == name);
        if (s == null)
        {
            return;
        }
        s.source.volume = 0;
    }

    public void ReturnVolume(string name)
    {
        Sound s = Array.Find(sounds, sound => sound.name == name);
        if (s == null)
        {
            return;
        }
        s.source.volume = volumeControl.value;
    }

    public void swishNoise()
    {
        sounds[0].source.volume = 1f;
    }

    public void StopPrevious(int index)
    {
        if (sounds[index].source.isPlaying)
        {
            sounds[index].source.Stop();
        }
        else
        {
            return;
        }
    }
}