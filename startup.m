%% ========================================================================
%  PROJE BAŞLATICI (STARTUP.M)
%  Yapay Zeka Destekli Senkron Makine Sürücüsü Tork Kontrolü (DNN-1 & DNN-2)
%  ve 4-Sınıflı Kestirimci Bakım / Arıza Teşhisi (Predictive Maintenance)
%  ========================================================================

proje_koku = fileparts(mfilename('fullpath'));

% 1. Tüm Modüler Alt Klasörleri MATLAB Yoluna (Path) Ekle
alt_dizinler = {
    proje_koku, ...
    fullfile(proje_koku, 'Ortak_Veri_ve_Parametreler'), ...
    fullfile(proje_koku, 'Bolum1_YapayZeka_TorkKontrolu'), ...
    fullfile(proje_koku, 'Bolum1_YapayZeka_TorkKontrolu', 'Mat_Dosyalari'), ...
    fullfile(proje_koku, 'Bolum1_YapayZeka_TorkKontrolu', 'Gorseller'), ...
    fullfile(proje_koku, 'Bolum2_KestirimciBakim_ArizaTeshisi'), ...
    fullfile(proje_koku, 'Bolum2_KestirimciBakim_ArizaTeshisi', 'Mat_Dosyalari'), ...
    fullfile(proje_koku, 'Bolum2_KestirimciBakim_ArizaTeshisi', 'Gorseller')
};

for i_dizin = 1:numel(alt_dizinler)
    if exist(alt_dizinler{i_dizin}, 'dir')
        addpath(alt_dizinler{i_dizin});
    end
end

% 2. Ortak Makine Parametrelerini ve 3B Akım Referans Haritalarını Yükle
SMTorqueControlData;

% 3. Kestirimci Bakım Varsayılan Parametrelerini ve Tablolarını Çalışma Uzayına Hazırla
Cdc_PdM                 = Cdc;
ESR_PdM                 = 1e-4;
Rbat_PdM                = 1e-3;
Rs_PdM                  = Rs;
Lad_PdM                 = Lad;
Rfd_PdM                 = Rfd;
Gate_Fault_Mask         = [1; 1; 1; 1; 1; 1];
Stator_Unbalance_Gain   = [1; 1; 1];
Load_Scale_PdM          = 1.0;
Sensor_Offset_Drift_PdM = [0; 0; 0];

if ~isempty(which('PdM_Trained_Classifier.mat'))
    load(which('PdM_Trained_Classifier.mat'), ...
        'Mdl_RandomForest', 'Mdl_MultiSVM', 'ConfMat_CV', 'cv_acc_percent', 'svm_acc_percent', 'top_features', ...
        'PdM_Feature_Table', 'Feature_Ranking_Table', 'classes', ...
        'PdM_ClassificationLearner_Top12Table', 'PdM_ClassificationLearner_FullTable');
end

clear proje_koku alt_dizinler i_dizin;

% 4. Etkileşimli Komut Penceresi Karşılama Menüsü
fprintf('\n================================================================================\n');
fprintf('  YAPAY ZEKA DESTEKLİ SENKRON MAKİNE TORK KONTROLÜ VE KESTİRİMCİ BAKIM PROJESİ\n');
fprintf('================================================================================\n');
fprintf('  [OK] Tüm modüler klasörler MATLAB yoluna (Path) eklendi.\n');
fprintf('  [OK] 65 kW Senkron Makine parametreleri ve öznitelik tabloları yüklendi.\n\n');
fprintf('  HIZLI ARAYÜZ BAŞLATICI:\n');
fprintf('    • Canlı Demo    : <a href="matlab:edit(''Arayuzler_Icin_Hizli_Baslatici.mlx'')">Arayuzler_Icin_Hizli_Baslatici.mlx</a> (DFD, Classification Learner 35 Model, Deep Network Designer)\n\n');
fprintf('  BÖLÜM 1 — %%100 Yapay Zeka Tork Kontrolü (DNN-1 Karar + DNN-2 Kontrol):\n');
fprintf('    • Rehber (.mlx) : <a href="matlab:edit(''YapayZeka_TorkKontrolu_AdimAdim_Rehber.mlx'')">YapayZeka_TorkKontrolu_AdimAdim_Rehber.mlx</a>\n');
fprintf('    • Klasik Model  : <a href="matlab:open_system(''SMTorqueControl.slx'')">SMTorqueControl.slx</a> (Lookup Table + 3x PI)\n');
fprintf('    • AI Modeli     : <a href="matlab:open_system(''SMTorqueControl_AI.slx'')">SMTorqueControl_AI.slx</a> (DNN-1 + DNN-2, %%91.61 Hata Azaltımı)\n\n');
fprintf('  BÖLÜM 2 — 4-Sınıflı Kestirimci Bakım ve Arıza Teşhisi (PdM):\n');
fprintf('    • Rehber (.mlx) : <a href="matlab:edit(''KestirimciBakim_ArizaTeshisi_AdimAdim_Rehber.mlx'')">KestirimciBakim_ArizaTeshisi_AdimAdim_Rehber.mlx</a>\n');
fprintf('    • PdM Modeli    : <a href="matlab:open_system(''SMTorqueControl_PdM.slx'')">SMTorqueControl_PdM.slx</a> (5 Canlı Arıza Seçim Butonlu)\n');
fprintf('    • CL (35 Model) : <a href="matlab:classificationLearner(which(''PdM_ClassificationLearner_Oturumu.mat''))">Classification Learner Oturumunu Aç (35 Model Hazır — #1 Wide NN %%97.5)</a>\n');
fprintf('================================================================================\n\n');
