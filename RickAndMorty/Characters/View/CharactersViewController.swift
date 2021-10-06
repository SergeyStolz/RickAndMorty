import UIKit
import RealmSwift
import EasyPeasy

class CharactersViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CharacterCellDelegat {
    
    var presenter: CharacterViewOutput!
    
    // MARK: - Views
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width / 2.18,
                                 height:view.frame.width / 1.4)
        layout.sectionInset.left = 10
        layout.sectionInset.right = 10
        layout.sectionInset.top = 10
        return layout
    }()
    
    private lazy var notificationLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.backgroundColor = .black
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 6
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.register(
            CharacterCell.self,
            forCellWithReuseIdentifier: CharacterCell.identifier
        )
        collectionView.register(FooterCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: FooterCollectionReusableView.identifier
        )
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).footerReferenceSize = CGSize(
            width: collectionView.bounds.width,
            height: 100
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    private lazy var activityView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.hidesWhenStopped = true
        activityView.center = self.view.center
        activityView.color = .black
        return activityView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        print(Realm.Configuration.defaultConfiguration.fileURL)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    private func setupView() {
        view.addSubview(collectionView)
        view.addSubview(notificationLabel)
        
    }
    
    private func setupConstraints() {
        collectionView.easy.layout( Edges() )
        notificationLabel.easy.layout(
            CenterY(),
            CenterX(),
            Height(113),
            Width(view.frame.size.width-100)
        )
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        let data = presenter.characters?.results[indexPath.item]
        let characterDetail = CharacterDetailConfigurator.create(data: data)
        self.navigationController?.pushViewController(characterDetail, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let totalCount = presenter.characters?.info.count ?? 0
        let currentCount = presenter.characters?.results.count ?? 0
        
        if indexPath.item == currentCount - 1 {
            if currentCount < totalCount {
                presenter.getCharacters()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                                     withReuseIdentifier: FooterCollectionReusableView.identifier,
                                                                     for: indexPath) as! FooterCollectionReusableView
        footer.configure()
        footer.addSubview(activityView)
        activityView.easy.layout( CenterX().to(footer), CenterY().to(footer) )
        activityView.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.characters?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.identifier, for: indexPath) as! CharacterCell
        guard let character = presenter.characters?.results[indexPath.item] else { return UICollectionViewCell() }
        cell.fill(item: CharactersCellViewModel(character))
        cell.delegate = self
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 0.2
        cell.layer.cornerRadius = 13
        return cell
    }
    
    func infoStateDelegate(name: String, state: Bool) {
        if state {
            UIView.animate(withDuration: 1.0,
                           delay: 0.1,
                           options: .curveEaseOut,
                           animations: {
                self.notificationLabel.text = "\(name) успешно добавлен в избранное"
                self.notificationLabel.alpha = 0.7
            },
                           completion: { finished in
                UIView.animate(withDuration: 0.3, delay: 0.8, animations: {
                    self.notificationLabel.alpha = 0
                })
            })
        } else {
            UIView.animate(withDuration: 1.0,
                           delay: 0.1,
                           options: .curveEaseOut,
                           animations: {
                self.notificationLabel.text = "\(name) удален из избранного"
                self.notificationLabel.alpha = 1
            },
                           completion: { finished in
                UIView.animate(withDuration: 0.3, delay: 0.8, animations: {
                    self.notificationLabel.alpha = 0
                })
            })
        }
    }
}

extension CharactersViewController: CharacterViewInput {
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func succes() {
        self.collectionView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
