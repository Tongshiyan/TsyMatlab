function y=get_ware(tone, rythm,keynote_type,Soundzone_change,up_down)
%tone为音节，rythm为节拍，keynote_type为当前基调默认为C调，keynote_change为改变基调，up_down为音节升降
%Sound zone_change为改变音区；
   Fs=8192;
   freqs=[440*2.^(3/12),440*2^(5/12),440*2^(7/12),440*2^(8/12),440*2^(10/12),440*2^(12/12),440*2^(14/12)];%C调中音
   freqs=freqs*2.^((keynote_type-3)/12);
   freqs=freqs*2.^((Soundzone_change-2)*12/12);
   freqs=freqs*2.^((up_down-2)/12);
   x=linspace(0,2*pi*rythm,floor(Fs*rythm));
   y=(sin(freqs(tone)*x).*(1-(x/(2*pi*rythm))));
end